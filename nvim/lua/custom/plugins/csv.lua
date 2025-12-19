local M

-- handle lazy loading manually
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "csv" },
  callback = function()
    require("decisive").align_csv({})
  end,
})

M = {
  "emmanueltouzery/decisive.nvim",
  lazy = true,
  opts = {},
}

return M
