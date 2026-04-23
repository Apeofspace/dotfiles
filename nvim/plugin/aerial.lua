vim.schedule(function()
  vim.pack.add({
    --  "nvim-treesitter/nvim-treesitter" ,
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/stevearc/aerial.nvim",
  })

  require("mini.icons").setup()
  require("mini.icons").mock_nvim_web_devicons()
  require("aerial").setup({
    attach_mode = "global",
    layout = { placement = "edge", default_direction = "prefer_left" },
    autojump = false,       -- jump when cursor moves (nice with flash) default: false
    on_attach = function(bufnr)
      vim.keymap.set("n", "<leader><Up>", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial UP" })
      vim.keymap.set("n", "<leader><Down>", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial DOWN" })
    end,
  })
  vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Aerial open" })
end)
