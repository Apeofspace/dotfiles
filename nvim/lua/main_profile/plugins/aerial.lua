return {
  'stevearc/aerial.nvim',
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },
  config = function()
    require("aerial").setup({
      attach_mode = "global",
      layout = { placement = "edge", default_direction = "prefer_left" },
      autojump = false, -- jump when cursor moves (nice with flash) default: false
      open_automatic = false, -- default: false
      on_attach = function(bufnr)
        vim.keymap.set("n", "<leader><Up>", "<cmd>AerialPrev<CR>", { buffer = bufnr })
        vim.keymap.set("n", "<leader><Down>", "<cmd>AerialNext<CR>", { buffer = bufnr })
      end,
    })
    -- You probably also want to set a keymap to toggle aerial
    vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
  end,
}
