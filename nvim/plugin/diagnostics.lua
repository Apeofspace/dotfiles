-- vim.schedule(function()
--   vim.pack.add({ "https://github.com/rachartier/tiny-inline-diagnostic.nvim" })
--   require("tiny-inline-diagnostic").setup({
--     options = { multilines = { enabled = true } }
--   })
--   vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
-- end)

vim.pack.add({
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/iilw/nui-diagnostic.nvim",
})

require("nui-diagnostic").setup({})
vim.keymap.set("n", "<leader>e", require("nui-diagnostic").open, { desc = "Show diagnostic [E]rror messages" })
