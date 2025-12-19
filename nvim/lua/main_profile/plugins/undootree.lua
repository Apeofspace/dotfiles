return {
  { "mbbill/undotree", event = "VeryLazy" },
  vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle),
  -- atone looks nice but it doesn't show the last saved version
  -- { "XXiaoA/atone.nvim", cmd = "Atone", event = "VeryLazy", opts = { layout = { width = 0.2 } } },
  -- vim.keymap.set("n", "<leader>u", ":Atone toggle<CR>"),
}
