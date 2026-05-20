vim.schedule(function()
  vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })
  require("tiny-inline-diagnostic").setup({
    options = { multilines = { enabled = true } }
  })
  vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
end)
