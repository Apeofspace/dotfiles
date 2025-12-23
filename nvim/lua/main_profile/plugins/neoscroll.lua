local running_neovide = vim.g.neovide
-- local running_kitty = (vim.env.TERM_PROGRAM or vim.env.TERM) == "xterm-kitty"
-- local running_wezterm = (vim.env.TERM_PROGRAM or vim.env.TERM) == "WezTerm"
local M = {
  {
    "karb94/neoscroll.nvim",
    -- enabled = (not running_neovide) and (not running_wezterm),
    enabled = not running_neovide,
    event = "VeryLazy",
    opts = {
      easing = "quadratic",
      performance_mode = false,   -- disable treesitter
      hide_cursor = false,
    },
  },
}

return M
