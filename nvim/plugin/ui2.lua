vim.o.cmdheight = 0
require('vim._core.ui2').enable({})

vim.o.cmdheight = 0
vim.pack.add({ "https://github.com/rachartier/tiny-cmdline.nvim" })
require("tiny-cmdline").setup({
  position = { y = "10%" }
})
