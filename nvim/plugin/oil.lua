vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/nvim-mini/mini.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
  })

  require("mini.icons").setup({})
  require("oil").setup({
    delete_to_trash = true,
    view_options = { show_hidden = true },
    keymaps = { ["q"] = { "actions.close", mode = "n" }, },
  })
  vim.keymap.set("n", "<leader>oi", function() require("oil").open() end, { desc = "[O]il" })
end)
