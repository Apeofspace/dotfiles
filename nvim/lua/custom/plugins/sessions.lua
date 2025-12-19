return {
  {
    -- this is a fork of folkes persistence.
    -- It works really well with no config and has no errors that other sessionizers have
    -- the only problem with autoload is that it loads when piping into nvim like echo asd | nvim -
    "olimorris/persisted.nvim",
    lazy = false,
    opts = {
      autoload = true,
      use_git_branch = true,
    },
    vim.keymap.set("n", "<leader>os", "<cmd>SessionSelect<CR>") -- this is basically for neovide
  },
  {
    -- close unused buffers after 20 min
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}
