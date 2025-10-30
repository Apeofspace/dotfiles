return {
  -- { "mbbill/undotree", event = "VeryLazy" },
  -- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle),
  { "XXiaoA/atone.nvim", cmd = "Atone", event = "VeryLazy", opts = { layout = { width = 0.2 } } },
  vim.keymap.set("n", "<leader>u", ":Atone toggle<CR>"),
}
