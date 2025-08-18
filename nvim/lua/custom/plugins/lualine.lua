local get_linecount = function()
  return vim.fn.line("$") .. " lines" or ""
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
  lualine_x = { "encoding", "filesize", "filetype" },
  lualine_y = { get_linecount },
  lualine_z = { "location" },
}

local tabline_config = {
  lualine_a = { { "tabs", mode = 2 } },
}

local M = {
  {
    -- https://neoland.dev/plugin/8327
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { globalstatus = true }, -- single bar
        sections = section_config,
        tabline = tabline_config,
      })
      -- the reason config is used here is that lualine overrites showtabline to 2
      -- so I need to manually reset it to 1 AFTER it loads
      vim.opt.showtabline = 1
    end,
  },
}

return M
