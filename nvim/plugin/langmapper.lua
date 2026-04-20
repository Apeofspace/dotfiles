-- this needs to be the last thing loaded
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    vim.pack.add({ "https://github.com/Wansmer/langmapper.nvim" })
    require("langmapper").setup({})
    require("langmapper").automapping({ buffer = false })
  end
})
