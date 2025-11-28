return {
  {
    -- this is a fork of folkes persistence.
    -- It works really well with no config and has no errors that other sessionizers have
    -- the only problem with autoload is that it loads when piping into nvim like echo asd | nvim -
    "olimorris/persisted.nvim",
    opts = {
      autoload = true,
      use_git_branch = true,
    },
    init = function()
      vim.keymap.set("n", "<leader>os", "<cmd>SessionSelect<CR>") -- this is basically for neovide
    end
  },
  {
    -- close unused buffers after 20 min
    "chrisgrieser/nvim-early-retirement",
    config = true,
    event = "VeryLazy",
  },
}

-- return {
--   {
--     -- it requires manual creation and manual load so it sucks cock and balls its so useless
--     "paradoxical-dev/restoration.nvim",
--     event = "VeryLazy", -- optional but recommended
--     opts = {
--       auto_save = true,
--       picker = { default = "snacks" }, -- vim|snacks
--       preserve = {folds = true},
--     }
--   },
--   vim.keymap.set("n", "<leader>Ss", function()
--     require("restoration").select()
--   end, { desc = "Select Session" }),
--
--   vim.keymap.set("n", "<leader>Sc", function()
--     require("restoration").select({ cwd = true })
--   end, { desc = "Select Session in Current Dir" }),
--
--   vim.keymap.set("n", "<leader>Sl", function()
--     require("restoration").load({ latest = true })
--   end, { desc = "Restore Last Session" })
-- }
