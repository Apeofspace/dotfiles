-- close unused buffers after 20 min
vim.schedule(function()
  vim.pack.add({ "https://github.com/chrisgrieser/nvim-early-retirement" })
  require("early-retirement").setup({})
end)
