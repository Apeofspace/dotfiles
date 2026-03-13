local M = {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "esmuellert/codediff.nvim",
    },
    event = "VeryLazy",
    config = function()
      local neogit = require("neogit")
      vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "NEOGIT" })
    end,
  },
  {
    "esmuellert/codediff.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    cmd = "CodeDiff",
    keys = {
      { "<Leader>gdo", "<cmd>CodeDiff<CR>", desc = "Current changes" },
      { "<Leader>gdh", "<cmd>CodeDiff history <CR>",   desc = "Commits history" },
      -- { "<Leader>gdf", "", desc = "THIS Files History" }, -- don't think its doable yet
    },
    config = function()
      local opts = { explorer = { view_mode = "tree" }, } -- change with "i" keybind
      require("codediff").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeDiffOpen",
        callback = function()
          vim.g.codediff_saved_showtabline = vim.o.showtabline
          vim.o.showtabline = 0
        end,
      })
      vim.api.nvim_create_autocmd("User", {
        pattern = "CodeDiffClose",
        callback = function()
          if vim.g.codediff_saved_showtabline then
            vim.o.showtabline = vim.g.codediff_saved_showtabline
            vim.g.codediff_saved_showtabline = nil
          end
        end,
      })
    end

  },
}

return M
