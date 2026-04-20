local get_linecount = function()
  -- return vim.fn.line("$") .. " lines" or ""
  local totallines = vim.fn.line("$")
  local thisline   = string.format("%" .. #tostring(totallines) .. "s", vim.fn.line(".")) -- right-aligned padded to #totallines
  local col        = string.format("%-3s", vim.fn.col("."))                               -- left-aligned padded to 3
  return thisline .. "/" .. totallines .. ":" .. col
end

-- this makes some text appear like recording macro etc
local function noice_stuff()
  local ok, noice = pcall(require, "noice")
  if not ok then
    return nil
  end
  return {
    noice.api.statusline.mode.get,
    cond = noice.api.statusline.mode.has,
    color = { fg = "#ff9e64" },
  }
end

local section_config = {
  -- +-------------------------------------------------+
  -- | A | B | C                             X | Y | Z |
  -- +-------------------------------------------------+
  lualine_a = { "mode" },
  lualine_b = { "branch", "filename" },
  lualine_c = { "diagnostics", noice_stuff() }, -- yeah deal with it
  lualine_x = { "lsp_status", "encoding", "filetype" },
  lualine_y = {},
  lualine_z = { get_linecount },
}

local tabline_config = {
  lualine_a = { { "tabs", mode = 2 } },
}

-------------------------------------------------------

vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

-- it normally uses nvim_web_devicons but we make it use mini.icons
require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()

require("lualine").setup({
  options = {
    -- globalstatus = true, -- uncomment for single bar
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },                                  -- single bar unfortunately only works for bottom statusbar and not winbar
  sections = section_config,
  inactive_sections = section_config, -- comment out for single bar
  -- winbar = { lualine_c = { "filename" } },
  -- inactive_winbar = { lualine_c = { "filename" } },
  tabline = tabline_config,
})


-- the reason config is used here is that lualine overrites showtabline to 2
-- so I need to manually reset it to 1 AFTER it loads
vim.opt.showtabline = 1
