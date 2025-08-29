require("custom.set")
require("custom.neovide") -- config neovide

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

local active_scheme = require("custom.plugins.colorscheme").read_colorscheme()

require("lazy").setup({
  change_detection = {
    notify = false,
  },
  import = "custom.plugins",
  install = { colorscheme = active_scheme },
})

if active_scheme then
  vim.cmd("colorscheme " .. active_scheme)
end

require("custom.lsp") -- config LSP servers

-- require("custom.scopehighlight") -- testing

require("langmapper").automapping({ buffer = false })
