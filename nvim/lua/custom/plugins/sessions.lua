-- this is a fork of folkes persistence.
-- It works really well with no config and has no errors that other sessionizers have
return {
  {
    "olimorris/persisted.nvim",
    -- event = "BufReadPre", -- Ensure the plugin loads only when a buffer has been loaded
    opts = {
      autoload = true,
      use_git_branch = true,
    },
    init = function()
      vim.keymap.set("n", "<leader>os", "<cmd>SessionSelect<CR>") -- this is basically for neovide
    end
  }
}
