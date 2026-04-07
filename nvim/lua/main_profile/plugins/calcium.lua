return {
  "necrom4/calcium.nvim",
  enabled = false, -- this plugin is very cool but I've used it 0 times
  cmd = { "Calcium" },
  opts = {},
  keys = {
    { "<leader>cc", ":Calcium<CR>", desc = "Calculate", mode = { "n", "v" }, silent = true},
  }
}
