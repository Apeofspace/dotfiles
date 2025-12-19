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

local M = {
  {
    -- https://neoland.dev/plugin/8327
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- enabled = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          globalstatus = true,
          section_separators = { left = '', right = '' },
          component_separators = { left = '', right = '' }
        }, -- single bar (unfortunately only works for bottom statusbar and not winbar)
        sections = section_config,
        -- winbar = { lualine_c = { "filename" } },
        -- inactive_winbar = { lualine_c = { "filename" } },
        tabline = tabline_config,
      })
      -- the reason config is used here is that lualine overrites showtabline to 2
      -- so I need to manually reset it to 1 AFTER it loads
      vim.opt.showtabline = 1
    end,
  },
  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    -- event = "VeryLazy", -- if its very lazy it doesnt load side buffer
    -- enabled = false,
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
  },
}

return M
