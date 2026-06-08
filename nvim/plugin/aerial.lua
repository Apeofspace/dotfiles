vim.pack.add({
  --  "nvim-treesitter/nvim-treesitter" ,
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/stevearc/aerial.nvim",
})
-- aerial actually lazy loads itself

require("mini.icons").setup()
require("mini.icons").mock_nvim_web_devicons()
require("aerial").setup({
  attach_mode = "global",
  layout = { placement = "edge", default_direction = "prefer_left" },
  -- autojump = true, -- jump when cursor moves (nice with flash) default: false
  show_guides = true,
  on_attach = function(bufnr)
    vim.keymap.set("n", "<leader><Up>", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial UP" })
    vim.keymap.set("n", "<leader><Down>", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial DOWN" })
    -- require("aerial").focus()
  end,
})
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Aerial open" })
