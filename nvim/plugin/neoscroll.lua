-- local running_kitty = (vim.env.TERM_PROGRAM or vim.env.TERM) == "xterm-kitty"
local running_neovide = vim.g.neovide
if running_neovide == true then
  return
end

vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/karb94/neoscroll.nvim" }
  })
  require("neoscroll").setup({
    easing = "quadratic",
    performance_mode = false, -- disable treesitter
    hide_cursor = false,
    stop_eof = false,
  }
  )
end)
