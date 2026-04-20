vim.schedule(function()
  vim.pack.add({
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/MunifTanjim/nui.nvim",
    "https://github.com/esmuellert/codediff.nvim",
    "https://github.com/NeogitOrg/neogit",
  })

  local neogit = require("neogit")
  neogit.setup({})
  vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "NEOGIT" })

  local codediff = require("codediff")
  codediff.setup({ explorer = { view_mode = "tree" } })
  vim.keymap.set("n", "<Leader>gdo", "<cmd>CodeDiff<CR>", { desc = "Current changes" })
  vim.keymap.set("n", "<Leader>gdh", "<cmd>CodeDiff history <CR>", { desc = "Commits history" })
  vim.keymap.set("n", "<Leader>gdf", "<cmd>CodeDiff history %<CR>", { desc = "THIS Files History" })
end)


-- vim.api.nvim_create_user_command("CodeDiff", function()
--   vim.api.nvim_del_user_command("CodeDiff")
--   local codediff = require("codediff")
--   codediff.setup({ explorer = { view_mode = "tree" } })
--   vim.keymap.set("n", "<Leader>gdo", "<cmd>CodeDiff<CR>", { desc = "Current changes" })
--   vim.keymap.set("n", "<Leader>gdh", "<cmd>CodeDiff history <CR>", { desc = "Commits history" })
--   vim.keymap.set("n", "<Leader>gdf", "<cmd>CodeDiff history %<CR>", { desc = "THIS Files History" })
--   -- vim.cmd("CodeDiff")
-- end, {desc = "load CodeDiff"})
