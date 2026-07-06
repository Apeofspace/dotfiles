-- https://www.compart.com/en/unicode to search Unicode
_G.tools = {
  ui = {
    icons = {
      branch = "",
      bullet = "•",
      open_bullet = "○",
      ok = "✔",
      d_chev = "∨",
      ellipses = "…",
      node = "╼",
      document = "≡",
      lock = "",
      r_chev = ">",
      warning = " ",
      error = " ",
      info = "󰌶 ",
    },
    kind_icons = {
      Array = " 󰅪 ",
      BlockMappingPair = " 󰅩 ",
      Boolean = "  ",
      BreakStatement = " 󰙧 ",
      Call = " 󰃷 ",
      CaseStatement = " 󰨚 ",
      Class = "  ",
      Color = "  ",
      Constant = "  ",
      Constructor = " 󰆧 ",
      ContinueStatement = "  ",
      Copilot = "  ",
      Declaration = " 󰙠 ",
      Delete = " 󰩺 ",
      DoStatement = " 󰑖 ",
      Element = " 󰅩 ",
      Enum = "  ",
      EnumMember = "  ",
      Event = "  ",
      Field = "  ",
      File = "  ",
      Folder = "  ",
      ForStatement = "󰑖 ",
      Function = " 󰆧 ",
      GotoStatement = " 󰁔 ",
      Identifier = " 󰀫 ",
      IfStatement = " 󰇉 ",
      Interface = "  ",
      Keyword = "  ",
      List = " 󰅪 ",
      Log = " 󰦪 ",
      Lsp = "  ",
      Macro = " 󰁌 ",
      MarkdownH1 = " 󰉫 ",
      MarkdownH2 = " 󰉬 ",
      MarkdownH3 = " 󰉭 ",
      MarkdownH4 = " 󰉮 ",
      MarkdownH5 = " 󰉯 ",
      MarkdownH6 = " 󰉰 ",
      Method = " 󰆧 ",
      Module = " 󰅩 ",
      Namespace = " 󰅩 ",
      Null = " 󰢤 ",
      Number = " 󰎠 ",
      Object = " 󰅩 ",
      Operator = "  ",
      Package = " 󰆧 ",
      Pair = " 󰅪 ",
      Property = "  ",
      Reference = "  ",
      Regex = "  ",
      Repeat = " 󰑖 ",
      Return = " 󰌑 ",
      RuleSet = " 󰅩 ",
      Scope = " 󰅩 ",
      Section = " 󰅩 ",
      Snippet = "  ",
      Specifier = " 󰦪 ",
      Statement = " 󰅩 ",
      String = "  ",
      Struct = "  ",
      SwitchStatement = " 󰨙 ",
      Table = " 󰅩 ",
      Terminal = "  ",
      Text = " 󰀬 ",
      Type = "  ",
      TypeParameter = "  ",
      Unit = "  ",
      Value = "  ",
      Variable = "  ",
      WhileStatement = " 󰑖 ",
    },
  },
  nonprog_modes = {
    ["markdown"] = true,
    ["org"] = true,
    ["orgagenda"] = true,
    ["text"] = true,
  },
}

local icons_spaced = {}
for key, value in pairs(_G.tools.ui.kind_icons) do
  icons_spaced[key] = value .. " "
end
_G.tools.ui.kind_icons_spaced = icons_spaced

-- Cache with longer lifetime
local git_info_cache = setmetatable({}, { __mode = "k" })
local last_git_update = 0
local GIT_UPDATE_INTERVAL = 2000 -- ms (update git info max every 2 seconds)

tools.get_path_root = function(path)
  if path == "" then return nil end
  if vim.b.path_root then return vim.b.path_root end

  local root = vim.fs.root(path, { ".git", "pyproject.toml", "Cargo.toml", "package.json" })
  if root then vim.b.path_root = root end
  return root
end

local function git_cmd(root, ...)
  if not root then return nil end
  local job = vim.system({ "git", "-C", root, ... }, { text = true }):wait()
  if job.code ~= 0 then return nil end
  return vim.trim(job.stdout)
end

local function get_git_info(root)
  if not root then return nil, nil end

  local now = vim.uv.now()
  if git_info_cache[root] and (now - last_git_update < GIT_UPDATE_INTERVAL) then
    return git_info_cache[root].remote, git_info_cache[root].branch
  end

  local remote = git_cmd(root, "config", "--get", "remote.origin.url")
      or git_cmd(root, "config", "--get", "remote.upstream.url")

  if remote then
    remote = remote:gsub(":", "/"):gsub("%.git$", ""):match("([^/]+/[^/]+)$") or remote
  end

  local branch = git_cmd(root, "rev-parse", "--abbrev-ref", "HEAD")
      or git_cmd(root, "symbolic-ref", "--short", "HEAD")

  if branch == "HEAD" or not branch then
    local commit = git_cmd(root, "rev-parse", "--short", "HEAD")
    branch = commit and ("HEAD (" .. commit .. ")") or "HEAD"
  end

  git_info_cache[root] = { remote = remote, branch = branch }
  last_git_update = now

  return remote, branch
end

-- highlighting -----------------------------
tools.hl_str = function(hl, str) return "%#" .. hl .. "#" .. str .. "%*" end

tools.group_number = function(num, sep)
  if num < 999 then return tostring(num) end
  num = tostring(num)
  return num:reverse():gsub("(%d%d%d)", "%1" .. sep):reverse():gsub("^,", "")
end

--------------------------------------------------------
local M = {}
local api, fn = vim.api, vim.fn
local get_opt = api.nvim_get_option_value
local icons = tools.ui.icons

local ICON = {
  branch = { "DiagnosticOk", icons.branch },
  file = { "NonText", icons.node },
  fileinfo = { "Function", icons.document },
  nomodifiable = { "DiagnosticWarn", icons.bullet },
  modified = { "DiagnosticError", icons.bullet },
  readonly = { "DiagnosticWarn", icons.lock },
  error = { "DiagnosticError", icons.error },
  warn = { "DiagnosticWarn", icons.warning },
}

for k, v in pairs(ICON) do
  ICON[k] = tools.hl_str(v[1], v[2])
end

local ORDER = { "pad", "path", "mod", "ro", "sep", "diag", "fileinfo", "pad", "scrollbar", "pad" }
local PAD = " "
local SEP = "%="
local SBAR = { "▔", "🮂", "🬂", "🮃", "▀", "▄", "▃", "🬭", "▂", "▁" }

local function concat(parts)
  local out, i = {}, 1
  for _, k in ipairs(ORDER) do
    if parts[k] and parts[k] ~= "" then
      out[i] = parts[k]
      i = i + 1
    end
  end
  return table.concat(out, " ")
end

-- path and git info -----------------------------------------
local function path_widget(root, fname)
  local file_name = fn.fnamemodify(fname, ":t")
  if fname == "" then file_name = "[No Name]" end

  local icon, hl = require("mini.icons").get("file", file_name)
  local path_part = tools.hl_str(hl, icon) .. file_name

  if get_opt("buftype", {}) == "help" then
    return ICON.file .. path_part
  end

  local dir_path = ""
  if root then
    local rel = fname:sub(#root + 2)
    if rel and rel ~= "" then
      dir_path = fn.fnamemodify(rel, ":h")
      if dir_path ~= "." then dir_path = dir_path .. "/" end
    end
  end

  local remote, branch = get_git_info(root)
  local repo_info = ""
  if remote and branch then
    repo_info = string.format("%s %s @ %s ", ICON.branch, remote, branch)
  end

  local win_w = api.nvim_win_get_width(0)
  local need = #repo_info + #dir_path + #path_part
  if win_w < need + 5 then dir_path = "" end
  if win_w < need - #dir_path then repo_info = "" end

  return repo_info .. ICON.file .. " " .. dir_path .. path_part .. " "
end

-- diagnostics ---------------------------------------------
local function diagnostics_widget()
  local err_count = vim.diagnostic.count(0)[vim.diagnostic.severity.ERROR] or 0
  local warn_count = vim.diagnostic.count(0)[vim.diagnostic.severity.WARN] or 0

  local err_hl = err_count > 0 and "DiagnosticError" or "Comment"
  local warn_hl = warn_count > 0 and "DiagnosticWarn" or "Comment"

  return string.format(
    "%s %s %s %s ",
    tools.hl_str(err_hl, icons.error),
    tools.hl_str(err_hl, string.format("%-3d", err_count)),
    tools.hl_str(warn_hl, icons.warning),
    tools.hl_str(warn_hl, string.format("%-3d", warn_count))
  )
end

-- venv (UV improved) ---------------------------------------------
local function venv_widget()
  local winid = vim.g.statusline_winid
  if not winid or not api.nvim_win_is_valid(winid) then winid = 0 end
  local buf = api.nvim_win_get_buf(winid)
  if get_opt("filetype", { buf = buf }) ~= "python" then return "" end

  local env = vim.env.VIRTUAL_ENV or vim.env.UV_PROJECT_ENVIRONMENT or vim.env.UV_VIRTUAL_ENV
  if env and env ~= "" then
    return tools.hl_str("Comment", string.format("[.venv: %s] ", fn.fnamemodify(env, ":t")))
  end

  local root = tools.get_path_root(api.nvim_buf_get_name(buf))
  if root and vim.fn.isdirectory(root .. "/.venv") == 1 then
    return tools.hl_str("Comment", "[.venv] ")
  end

  local conda = vim.env.CONDA_DEFAULT_ENV
  if conda and conda ~= "" then
    return tools.hl_str("Comment", string.format("[conda: %s] ", conda))
  end

  return tools.hl_str("Comment", "[no venv]")
end

local function fileinfo_widget()
  local winid = vim.g.statusline_winid
  if not winid or not api.nvim_win_is_valid(winid) then winid = 0 end
  local buf = api.nvim_win_get_buf(winid)
  local ft = get_opt("filetype", { buf = buf })
  local lines = tools.group_number(api.nvim_buf_line_count(buf), ",")
  local str = ICON.fileinfo .. " "

  if not tools.nonprog_modes[ft] then
    return str .. string.format("%3s lines", lines)
  end

  local wc = fn.wordcount()
  if not wc.visual_words then
    return str .. string.format("%3s lines %3s words", lines, tools.group_number(wc.words, ","))
  end

  local vlines = math.abs(fn.line(".") - fn.line("v")) + 1
  return str .. string.format("%3s lines %3s words %3s chars",
    tools.group_number(vlines, ","),
    tools.group_number(wc.visual_words, ","),
    tools.group_number(wc.visual_chars, ","))
end

local function scrollbar_widget()
  local winid = vim.g.statusline_winid
  if not winid or not api.nvim_win_is_valid(winid) then winid = 0 end
  local buf = api.nvim_win_get_buf(winid)
  local cur = api.nvim_win_get_cursor(winid)[1]
  local total = api.nvim_buf_line_count(buf)
  if total == 0 then return tools.hl_str("Substitute", SBAR[1]:rep(2)) end

  local idx = math.floor((cur - 1) / total * (#SBAR - 1)) + 1
  return tools.hl_str("Substitute", SBAR[idx]:rep(2))
end

-- render ---------------------------------------------
function M.render()
  local winid = vim.g.statusline_winid
  if not winid or not api.nvim_win_is_valid(winid) then winid = 0 end

  local buf = api.nvim_win_get_buf(winid)
  local fname = api.nvim_buf_get_name(buf)
  local buftype = get_opt("buftype", { buf = buf })
  local root = buftype == "" and tools.get_path_root(fname) or nil

  if buftype ~= "" and buftype ~= "help" then
    fname = get_opt("filetype", { buf = buf })
  end

  local parts = {
    pad = PAD,
    path = path_widget(root, fname),
    venv = venv_widget(),
    mod = get_opt("modifiable", { buf = buf })
        and (get_opt("modified", { buf = buf }) and ICON.modified or " ")
        or ICON.nomodifiable,
    ro = get_opt("readonly", { buf = buf }) and ICON.readonly or "",
    sep = SEP,
    diag = diagnostics_widget(),
    fileinfo = fileinfo_widget(),
    scrollbar = scrollbar_widget(),
  }

  return concat(parts)
end

-- Inactive statusline same as active
vim.api.nvim_set_hl(0, "StatusLineNC", { link = "StatusLine" })
vim.api.nvim_set_hl(0, "StatusLineTermNC", { link = "StatusLine" })

vim.o.statusline = "%!v:lua.require('stolenstatusline').render()"
return M
