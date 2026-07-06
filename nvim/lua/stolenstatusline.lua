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

-- files and directories -----------------------------
local branch_cache = setmetatable({}, { __mode = "k" })
local remote_cache = setmetatable({}, { __mode = "k" })

--- get the path to the root of the current file.
tools.get_path_root = function(path)
  if path == "" then return end
  local root = vim.b.path_root
  if root then return root end
  local root_items = { ".git" }
  root = vim.fs.root(path, root_items)
  if root == nil then return nil end
  if root then vim.b.path_root = root end
  return root
end

local function git_cmd(root, ...)
  local job = vim.system({ "git", "-C", root, ... }, { text = true }):wait()
  if job.code ~= 0 then return nil, job.stderr end
  return vim.trim(job.stdout)
end

tools.get_git_remote_name = function(root)
  if not root then return nil end
  if remote_cache[root] then return remote_cache[root] end
  local out = git_cmd(root, "config", "--get", "remote.origin.url")
  if not out then return nil end
  out = out:gsub(":", "/"):gsub("%.git$", ""):match("([^/]+/[^/]+)$")
  remote_cache[root] = out
  return out
end

function tools.get_git_branch(root)
  if not root then return nil end
  if branch_cache[root] then return branch_cache[root] end
  local out = git_cmd(root, "rev-parse", "--abbrev-ref", "HEAD")
  if out == "HEAD" then
    local commit = git_cmd(root, "rev-parse", "--short", "HEAD")
    commit = tools.hl_str("Comment", "(" .. commit .. ")")
    out = string.format("%s %s", out, commit)
  end
  branch_cache[root] = out
  return out
end

-- LSP -----------------------------
tools.diagnostics_available = function()
  local clients = vim.lsp.get_clients({ bufnr = 0 })
  local diagnostics = vim.lsp.protocol.Methods.textDocument_publishDiagnostics
  for _, cfg in pairs(clients) do
    if cfg:supports_method(diagnostics) then return true end
  end
  return false
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
local api, fn, bo = vim.api, vim.fn, vim.bo
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
  visual = { "DiagnosticInfo", "‹› " },
}

for k, v in pairs(ICON) do
  ICON[k] = tools.hl_str(v[1], v[2])
end

local ORDER = {
  "pad",
  "path",
  "venv",
  "mod",
  "ro",
  "sep",
  "diag",
  "fileinfo",
  "pad",
  "scrollbar",
  "pad",
}

local PAD = " "
local SEP = "%="
local SBAR = { "▔", "🮂", "🬂", "🮃", "▀", "▄", "▃", "🬭", "▂", "▁" }

-- utilities -----------------------------------------
local function concat(parts)
  local out, i = {}, 1
  for _, k in ipairs(ORDER) do
    local v = parts[k]
    if v and v ~= "" then
      out[i] = v
      i = i + 1
    end
  end
  return table.concat(out, " ")
end

local function esc_str(str)
  return str:gsub("([%(%)%%%+%-%*%?%[%]%^%$])", "%%%1")
end

-- path and git info -----------------------------------------
local function path_widget(root, fname)
  local file_name = fn.fnamemodify(fname, ":t")
  local path, icon, hl
  icon, hl = require("mini.icons").get("file", file_name)
  if fname == "" then file_name = "[No Name]" end
  path = tools.hl_str(hl, icon) .. file_name

  if bo.buftype == "help" then return ICON.file .. path end

  local dir_path = fn.fnamemodify(fname, ":h") .. "/"
  if dir_path == "./" then dir_path = "" end

  local remote = tools.get_git_remote_name(root)
  local branch = tools.get_git_branch(root)
  local repo_info = ""

  if remote and branch then
    dir_path = dir_path:gsub("^" .. esc_str(root) .. "/", "")
    repo_info = string.format("%s %s @ %s ", ICON.branch, remote, branch)
  end

  local win_w = api.nvim_win_get_width(0)
  local need = #repo_info + #dir_path + #path
  if win_w < need + 5 then dir_path = "" end
  if win_w < need - #dir_path then repo_info = "" end

  return repo_info .. ICON.file .. " " .. dir_path .. path .. " "
end

-- diagnostics ---------------------------------------------
local function diagnostics_widget()
  if not tools.diagnostics_available() then return "" end
  local diag_count = vim.diagnostic.count()
  local err, warn =
    string.format("%-3d", diag_count[1] or 0),
    string.format("%-3d", diag_count[2] or 0)
  return string.format(
    "%s %s %s %s ",
    ICON.error,
    tools.hl_str("DiagnosticError", err),
    ICON.warn,
    tools.hl_str("DiagnosticWarn", warn)
  )
end

-- file/selection info -------------------------------------
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

  local wc = fn.wordcount() -- wordcount is window-local, so it's okay
  if not wc.visual_words then
    return str .. string.format("%3s lines %3s words", lines, tools.group_number(wc.words, ","))
  end

  local vlines = math.abs(fn.line(".") - fn.line("v")) + 1
  return str .. string.format(
    "%3s lines %3s words %3s chars",
    tools.group_number(vlines, ","),
    tools.group_number(wc.visual_words, ","),
    tools.group_number(wc.visual_chars, ",")
  )
end

-- python venv ---------------------------------------------
local function venv_widget()
  local winid = vim.g.statusline_winid
  if not winid or not api.nvim_win_is_valid(winid) then winid = 0 end
  local buf = api.nvim_win_get_buf(winid)
  local ft = get_opt("filetype", { buf = buf })

  if ft ~= "python" then return "" end

  local env = vim.env.VIRTUAL_ENV
  local str
  if env and env ~= "" then
    str = string.format("[.venv: %s] ", fn.fnamemodify(env, ":t"))
    return tools.hl_str("Comment", str)
  end

  env = vim.env.CONDA_DEFAULT_ENV
  if env and env ~= "" then
    str = string.format("[conda: %s] ", env)
    return tools.hl_str("Comment", str)
  end

  return tools.hl_str("Comment", "[no venv]")
end

-- scrollbar ---------------------------------------------
local function scrollbar_widget()
  local winid = vim.g.statusline_winid
  if not winid or not api.nvim_win_is_valid(winid) then
    winid = 0
  end

  local buf = api.nvim_win_get_buf(winid)
  local cur = api.nvim_win_get_cursor(winid)[1]
  local total = api.nvim_buf_line_count(buf)

  if total == 0 then
    return tools.hl_str("Substitute", SBAR[1]:rep(2))
  end

  local idx = math.floor((cur - 1) / total * (#SBAR - 1)) + 1
  return tools.hl_str("Substitute", SBAR[idx]:rep(2))
end

-- render ---------------------------------------------
function M.render()
  local winid = vim.g.statusline_winid
  if not winid or not api.nvim_win_is_valid(winid) then
    winid = 0
  end

  local buf = api.nvim_win_get_buf(winid)
  local fname = api.nvim_buf_get_name(buf)

  -- Use buffer-local buftype for the statusline window
  local buftype = get_opt("buftype", { buf = buf })
  local root = (buftype == "" and tools.get_path_root(fname)) or nil

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

vim.o.statusline = "%!v:lua.require('stolenstatusline').render()"
return M
