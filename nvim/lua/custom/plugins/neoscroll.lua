local running_neovide = vim.g.neovide
local running_kitty = (vim.env.TERM_PROGRAM or vim.env.TERM) == "xterm-kitty"
local running_wezterm = (vim.env.TERM_PROGRAM or vim.env.TERM) == "WezTerm"
local M = {
  {
    "karb94/neoscroll.nvim",
    -- enabled = (not running_neovide) and (not running_wezterm),
    enabled = not running_neovide,
    event = "VeryLazy",
    config = function()
      local neoscroll = require("neoscroll")
      neoscroll.setup({
        easing = "quadratic",
        performance_mode = false, -- disable treesitter
        hide_cursor = false,
      })
    end,
  },
}

return M
