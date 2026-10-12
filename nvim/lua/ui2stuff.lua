-- ui2stuff.lua
--
-- Center the built-in ui2 cmdline / dialog windows instead of the default
-- bottom-anchored layout (replaces rachartier/tiny-cmdline.nvim). ui2 is
-- Neovim 0.12's externalized cmdline + message UI with four floats
-- (`require('vim._core.ui2').wins`): cmd (the cmdline), dialog (modal prompts),
-- msg (ephemeral messages) and pager (`:messages`). We center cmd/dialog near
-- the top and stack a dialog above its prompt; regular messages stay at the
-- bottom and are dismissed on the next keypress (ui2's default, untouched).
--
-- How interception works: ui2 stores the module tables in `ui2.cmd`/`ui2.msg`
-- and dispatches events dynamically (`M.msg[event]`, `M.cmd[event]`), while
-- messages.lua calls `ui.msg.set_pos(...)` internally. Because Lua tables are
-- referenced, replacing fields on those module tables intercepts the internal
-- calls. We therefore wrap `messages.set_pos` (post-hook, so it wins over
-- ui2's bottom layout), `cmdline.cmdline_show` and `cmdline.cmdline_hide` (a
-- prompt closing restores the bottom layout).
--
-- `vim._core.ui2.cmdheight` snapshots `vim.o.cmdheight` at module load, so we
-- set the user's cmdheight (0) BEFORE requiring ui2; and `ui2.enable()` bails
-- when no UI is attached (headless), so enabling is deferred to `UIEnter`.
--
-- Float geometry (verified empirically on nvim 0.12.5): with a border the
-- config `row`/`col` are the border box's top-left, the text starts at
-- `row + b, col + b` (b = 1 when a border is drawn) and the border box is
-- `h + 2b` rows tall. This matches tiny-cmdline's math. Only the uniform
-- presets (none/single/double/rounded/solid) add exactly 1 cell per side, so
-- `winborder` is normalized to one of them (see `resolved_border`).

local api = vim.api

local M = {
  _initialized = false, -- setup() ran at least once
  _enabled = false, -- ui2 is enabled and our hooks are installed
  _disabled = false, -- gave up after too many errors
  _errors = 0, -- error counter; cleared by a success only if no error intervened
  _bumped = false, -- dirty flag: bump_error ran since the last counter reset
  _notified = false,
}

---@class Ui2StuffWidth
---@field value string|integer "60%" of columns, or an absolute column count
---@field min integer
---@field max integer

---@class Ui2StuffConfig
---@field position { x: string|integer, y: string|integer } top-left over free space
---@field width Ui2StuffWidth
---@field border string|nil nil -> vim.o.winborder, normalized to a uniform preset
---                  (none/single/double/rounded/solid); anything else -> "rounded"
---@field menu_col_offset integer completion menu anchor offset (blink.cmp)
---@field stack boolean stack dialog above cmdline as one block
---@field cmdheight integer|nil 'cmdheight' to force while ui2 is enabled

local defaults = {
  position = { x = '50%', y = '10%' },
  width = { value = '60%', min = 40, max = 80 },
  border = nil,
  menu_col_offset = 3,
  stack = true,
  cmdheight = 0,
}

local config = vim.tbl_deep_extend('force', defaults, {})
M.config = config

-- Runtime state.
local ui2 ---@type table?
local cmdline ---@type table?
local messages ---@type table?
local orig = {} ---@type { cmdline_show?: function, cmdline_hide?: function, set_pos?: function }
local saved ---@type table? original window configs + vim.g.ui_cmdline_pos

-- ---------------------------------------------------------------------------
-- Small helpers
-- ---------------------------------------------------------------------------

--- "60%" -> floor(available * 60 / 100); an integer (or numeric string) is
--- used as an absolute value. Mirrors tiny-cmdline's parse_dimension.
local function parse_dimension(value, available)
  if type(value) == 'string' then
    local pct = value:match('^(%-?%d+)%%$')
    if pct then
      return math.floor(available * tonumber(pct) / 100)
    end
    return math.floor(tonumber(value) or 0)
  end
  return math.floor(value or 0)
end

local function clamp(v, lo, hi)
  return math.max(lo, math.min(hi, v))
end

--- Border presets we can compute geometry for: each adds exactly one cell per
--- side. Any other 'winborder' value (e.g. "shadow", an 8-cell spec or a table)
--- has unknown geometry, so it falls back to "rounded".
local BORDER_PRESETS = {
  none = true,
  single = true,
  double = true,
  rounded = true,
  solid = true,
}

--- Resolve the effective border, normalized to a uniform preset.
local function resolved_border()
  local b = config.border
  if b == nil then
    local wb = vim.o.winborder
    b = (wb ~= nil and wb ~= '') and wb or 'rounded'
  end
  if type(b) ~= 'string' or not BORDER_PRESETS[b] then
    b = 'rounded'
  end
  return b
end

--- Number of cells the border adds per side (0 for none).
local function border_size(border)
  return (border == nil or border == '' or border == 'none') and 0 or 1
end

local function valid_win(win)
  if win and win ~= -1 and api.nvim_win_is_valid(win) then
    return win
  end
  return nil
end

--- Set 'cmdheight' without firing autocmds (avoids cursor jumps / re-entrancy)
--- and keep ui2's internal snapshot in sync.
local function set_cmdheight(value)
  if value == nil then
    return
  end
  pcall(function()
    if vim._with then
      vim._with({ noautocmd = true, o = { splitkeep = 'screen' } }, function()
        vim.o.cmdheight = value
      end)
    else
      vim.o.cmdheight = value
    end
    if ui2 then
      -- ui2 snapshots 'cmdheight' at load and its OptionSet handler updates this
      -- field; because we write the option with noautocmd, sync it ourselves so
      -- ui2's internals never diverge from the option value.
      ui2.cmdheight = value
    end
  end)
end

-- ---------------------------------------------------------------------------
-- Fail-safety
-- ---------------------------------------------------------------------------

--- Give up: put the original ui2 functions back, restore the saved geometry and
--- stop touching anything.
---@param err any
local function disable(err)
  if M._disabled then
    return
  end
  M._disabled, M._enabled = true, false
  -- Put the layout back first, so we don't leave the windows centered or a stale
  -- `vim.g.ui_cmdline_pos` behind (blink.cmp would keep anchoring to it).
  pcall(M.restore)
  if cmdline and orig.cmdline_show and orig.cmdline_hide then
    cmdline.cmdline_show, cmdline.cmdline_hide = orig.cmdline_show, orig.cmdline_hide
  end
  if messages and orig.set_pos then
    messages.set_pos = orig.set_pos
  end
  if not M._notified then
    M._notified = true
    vim.notify(
      ('[ui2stuff] disabling after repeated errors: %s'):format(tostring(err)),
      vim.log.levels.WARN
    )
  end
  vim.g.ui2stuff_enabled = false
end

-- Count an error and, once too many accumulate without an intervening clean
-- reposition, trip the fail-safe. `M._bumped` marks that an error happened so a
-- following success does not silently erase a persistent upstream failure.
local function bump_error(err)
  M._errors = M._errors + 1
  M._bumped = true
  if M._errors >= 20 then
    disable(err)
  end
end

-- ---------------------------------------------------------------------------
-- Geometry
-- ---------------------------------------------------------------------------

--- Save the pre-centering layout (bottom anchored) once per session so that
--- regular messages can be restored to the bottom.
local function capture()
  if saved then
    return
  end
  saved = { ui_cmdline_pos = vim.g.ui_cmdline_pos, cmd = nil, dialog = nil }
  for _, key in ipairs({ 'cmd', 'dialog' }) do
    local win = ui2.wins and ui2.wins[key]
    if win and api.nvim_win_is_valid(win) then
      local c = api.nvim_win_get_config(win)
      local s = {}
      for _, f in ipairs({ 'relative', 'anchor', 'row', 'col', 'width', 'border' }) do
        if c[f] ~= nil then
          s[f] = c[f]
        end
      end
      saved[key] = s
    end
  end
end

--- Restore the saved bottom layout + `vim.g.ui_cmdline_pos`.
function M.restore()
  pcall(function()
    if not saved then
      return
    end
    if ui2 then
      for _, key in ipairs({ 'cmd', 'dialog' }) do
        local s = saved[key]
        local win = ui2.wins and ui2.wins[key]
        if s and win and api.nvim_win_is_valid(win) then
          api.nvim_win_set_config(win, s)
        end
      end
    end
    -- Assigning nil deletes the global (restores blink.cmp's default anchor).
    vim.g.ui_cmdline_pos = saved.ui_cmdline_pos
  end)
  -- Make sure the reserved bottom line is released again after the prompt.
  set_cmdheight(config.cmdheight)
end

--- Ask Neovim to repaint after we moved a floating window. ui2 repaints after
--- its own handlers, but moves we perform on top of them (notably for the
--- dialog during a `confirm()` prompt) are otherwise left unflushed and the
--- screen keeps showing the stale layout. Scheduled so it runs after the
--- current UI event, and coalesced so a burst of calls paints once.
local redraw_scheduled = false
local function request_redraw()
  if redraw_scheduled then
    return
  end
  redraw_scheduled = true
  vim.schedule(function()
    redraw_scheduled = false
    if M._disabled then
      return
    end
    pcall(api.nvim__redraw, { flush = true })
  end)
end

--- Center the active cmdline / dialog. Runs only while `cmdline.level > 0`,
--- i.e. an interactive prompt is active; otherwise ui2's bottom layout wins.
local function do_reposition()
  if not M._enabled or M._disabled or not ui2 or not cmdline then
    return
  end
  if cmdline.level == 0 then
    return -- not a prompt: leave messages/cmdline at the bottom
  end

  -- ui2's internal `win_config()` bumps 'cmdheight' to the cmdline height while
  -- a prompt is shown; with the cmd window floated to the center that leaves a
  -- blank strip at the bottom and shifts the statusline up by one row. Force
  -- the configured value back so the layout does not move.
  set_cmdheight(config.cmdheight)
  capture()

  local cols, lines = vim.o.columns, vim.o.lines
  local border = resolved_border()
  local b = border_size(border)

  local w = clamp(parse_dimension(config.width.value, cols), config.width.min, config.width.max)
  w = math.max(1, math.min(w, cols - 2 * b))

  local cmd_win = valid_win(ui2.wins.cmd)
  local dlg_win = valid_win(ui2.wins.dialog)
  local dlg_visible = dlg_win ~= nil and not api.nvim_win_get_config(dlg_win).hide

  -- Decide the top-to-bottom stack. Dialog goes above the cmdline; when the
  -- dialog is absent (or stacking is off) the cmdline is centered alone.
  local stack = {} ---@type { win: integer, key: string, h: integer }[]
  if config.stack and dlg_visible and cmd_win then
    stack = { { win = dlg_win, key = 'dialog' }, { win = cmd_win, key = 'cmd' } }
  elseif cmd_win then
    stack = { { win = cmd_win, key = 'cmd' } }
  elseif dlg_visible then
    stack = { { win = dlg_win, key = 'dialog' } }
  else
    return
  end

  -- Content heights. The cmd window keeps its ui2-managed height. For the dialog
  -- our width may change wrapping, so measure the text; only when it exceeds
  -- ui2's own height limit do we re-run ui2's dialog layout (`orig.set_pos`) to
  -- clamp it and install its spill markers / paging. A normal short dialog just
  -- takes the measured height and skips that call (no extra redraw/flash).
  for _, it in ipairs(stack) do
    if it.key == 'dialog' then
      api.nvim_win_set_config(it.win, { width = w })
      local texth = math.max(1, api.nvim_win_text_height(it.win, {}).all)
      local cfgmin = (ui2.cfg and ui2.cfg.msg and ui2.cfg.msg.dialog and ui2.cfg.msg.dialog.height) or 0.5
      local limit = cfgmin > 1 and cfgmin or math.ceil(lines * cfgmin)
      if dlg_visible and texth > limit and orig.set_pos then
        pcall(orig.set_pos, 'dialog')
        it.h = math.max(1, api.nvim_win_get_height(it.win))
      else
        it.h = texth
      end
    else
      it.h = math.max(1, api.nvim_win_get_height(it.win))
    end
  end

  -- Best-effort fit: the cmd prompt is the priority. Cap the dialog so the
  -- dialog box + cmd box fit together when possible; if even the cmd alone
  -- cannot fit the block is left to overflow (nvim then truncates/relocates the
  -- float -- nothing else we can do).
  local cmd_h = 0
  for _, it in ipairs(stack) do
    if it.key == 'cmd' then
      cmd_h = it.h
    end
  end
  local dlg_budget = math.max(1, lines - (cmd_h + 2 * b) - 2 * b)
  for _, it in ipairs(stack) do
    if it.key == 'dialog' then
      it.h = math.min(it.h, dlg_budget)
    end
  end

  -- The visible block is each window's border box stacked with no gap.
  local block_h = 0
  for _, it in ipairs(stack) do
    block_h = block_h + it.h + 2 * b
  end

  -- y is applied over the free space, then clamped (best effort) so the block
  -- stays on screen and the cmd prompt is not pushed below the last row.
  local row = clamp(parse_dimension(config.position.y, lines - block_h), 0, math.max(0, lines - block_h))
  local col = math.max(0, parse_dimension(config.position.x, cols - (w + 2 * b)))

  local cmd_bottom ---@type integer?
  for _, it in ipairs(stack) do
    local wcfg = { relative = 'editor', anchor = 'NW', row = row, col = col, width = w, border = border }
    if it.key == 'dialog' then
      wcfg.height = it.h
    end
    api.nvim_win_set_config(it.win, wcfg)
    if it.key == 'cmd' then
      cmd_bottom = row + it.h + 2 * b -- first row below the cmd border box
    end
    row = row + it.h + 2 * b -- next border box starts right below
  end

  if cmd_bottom then
    -- blink.cmp reads this and stores it as a (1,0)-indexed screen position.
    vim.g.ui_cmdline_pos = { cmd_bottom, col + b + (config.menu_col_offset or 0) }
  else
    -- No cmd window in the stack (dialog-only): drop any stale anchor from a
    -- previous reposition so blink.cmp doesn't follow a phantom cmdline.
    vim.g.ui_cmdline_pos = saved and saved.ui_cmdline_pos or nil
  end

  request_redraw()
end

--- Public, pcall-guarded entry point (also used by autocmds).
function M.reposition()
  if M._disabled or not M._enabled then
    return
  end
  local ok, err = pcall(do_reposition)
  if ok then
    -- Only clear the counter when no error occurred since the last success.
    -- Otherwise a persistent upstream failure (bump, success, bump, success, …)
    -- would be zeroed every time and never reach the disable threshold.
    if not M._bumped then
      M._errors = 0
    end
    M._bumped = false
  else
    bump_error(err)
  end
end

-- ---------------------------------------------------------------------------
-- Enable + hook installation
-- ---------------------------------------------------------------------------

--- Install our wrappers over the ui2 module functions.
local wrapped = false
local function wrap()
  if wrapped then
    return
  end
  wrapped = true
  orig.cmdline_show = cmdline.cmdline_show
  orig.cmdline_hide = cmdline.cmdline_hide
  orig.set_pos = messages.set_pos

  cmdline.cmdline_show = function(...)
    local ok, err = pcall(orig.cmdline_show, ...)
    if not ok then
      bump_error(err)
    end
    M.reposition()
  end

  cmdline.cmdline_hide = function(...)
    local ok, err = pcall(orig.cmdline_hide, ...)
    if not ok then
      bump_error(err)
    end
    -- Fully hidden: restore the bottom layout for post-command messages.
    if not M._disabled and cmdline.level == 0 then
      M.restore()
    end
  end

  messages.set_pos = function(...)
    local ok, err = pcall(orig.set_pos, ...)
    if not ok then
      bump_error(err)
    end
    -- Run AFTER ui2's own positioning so our centered layout is final.
    M.reposition()
  end
end

local function enable()
  if M._enabled or M._disabled then
    return
  end

  -- Must precede require('vim._core.ui2'): it snapshots 'cmdheight' at load.
  set_cmdheight(config.cmdheight)

  local ok_ui, ui = pcall(require, 'vim._core.ui2')
  local ok_c, cmdl = pcall(require, 'vim._core.ui2.cmdline')
  local ok_m, msgs = pcall(require, 'vim._core.ui2.messages')
  if
    not (
      ok_ui
      and ok_c
      and ok_m
      and type(ui) == 'table'
      and type(cmdl) == 'table'
      and type(msgs) == 'table'
      and type(ui.wins) == 'table'
      and type(cmdl.cmdline_show) == 'function'
      and type(cmdl.cmdline_hide) == 'function'
      and type(msgs.set_pos) == 'function'
    )
  then
    vim.notify('[ui2stuff] required ui2 internals are unavailable; leaving ui2 untouched', vim.log.levels.WARN)
    return
  end
  ui2, cmdline, messages = ui, cmdl, msgs

  local ok_enable, err = pcall(ui2.enable, {})
  if not ok_enable then
    vim.notify(('[ui2stuff] vim._core.ui2.enable failed: %s'):format(tostring(err)), vim.log.levels.WARN)
    ui2 = nil
    return
  end

  wrap()

  local group = api.nvim_create_augroup('ui2stuff', { clear = true })
  api.nvim_create_autocmd({ 'VimResized', 'TabEnter' }, {
    group = group,
    callback = function()
      vim.schedule(function()
        M.reposition()
      end)
    end,
    desc = 'Re-center the ui2 cmdline/dialog windows after resize or tab change.',
  })

  -- While enabled we own 'cmdheight': if it is changed at runtime (user or
  -- another plugin), force it back to the configured value and resync ui2's
  -- snapshot. Guarded on the new value so our own write cannot loop, and a
  -- no-op once the fail-safe has fired.
  if config.cmdheight ~= nil then
    api.nvim_create_autocmd('OptionSet', {
      group = group,
      pattern = 'cmdheight',
      callback = function(ev)
        if M._disabled then
          return
        end
        if tonumber(ev.option_new) ~= config.cmdheight then
          set_cmdheight(config.cmdheight)
          -- ui2's own OptionSet handler already (un)hid/resized its cmd window
          -- for the rejected value (ui2.lua check_cmdheight). Mirror the
          -- configured state so the cmd window can't stay visible while the
          -- option/snapshot read 0. Our write is noautocmd, so this can't loop.
          local cmd = ui2 and valid_win(ui2.wins and ui2.wins.cmd)
          if cmd then
            pcall(api.nvim_win_set_config, cmd, {
              height = math.max(config.cmdheight, 1),
              hide = config.cmdheight == 0,
            })
          end
        end
      end,
      desc = 'Keep cmdheight at the configured value while ui2stuff is enabled.',
    })
  end

  M._enabled = true
  vim.g.ui2stuff_enabled = true
end

--- Configure and enable. Idempotent; a later call with opts merges and
--- re-applies (used by the user to tweak the position at runtime).
---@param opts Ui2StuffConfig?
function M.setup(opts)
  if M._initialized then
    if opts and next(opts) ~= nil then
      config = vim.tbl_deep_extend('force', defaults, opts)
      M.config = config
      M.reposition()
    end
    return
  end
  M._initialized = true

  if opts and next(opts) ~= nil then
    config = vim.tbl_deep_extend('force', defaults, opts)
    M.config = config
  end

  if config.cmdheight ~= nil then
    set_cmdheight(config.cmdheight)
  end

  if #api.nvim_list_uis() == 0 then
    -- Headless / no UI: defer enabling until a UI attaches.
    api.nvim_create_autocmd('UIEnter', {
      once = true,
      callback = function()
        enable()
      end,
      desc = 'Deferred ui2stuff enable once a UI attaches.',
    })
    return
  end

  enable()
end

-- Auto-run so a plain `require('ui2stuff')` in the user's init is enough. The
-- scheduled call carries no opts, so a prior `M.setup{...}` is preserved.
vim.schedule(function()
  M.setup()
end)

return M
