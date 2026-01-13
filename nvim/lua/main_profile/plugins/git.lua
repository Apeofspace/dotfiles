local M = {
  {
    "sindrets/diffview.nvim",
    enabled = true,
    cmd = { "DiffviewOpen", "DiffviewFileHistory" },
    keys = {
      { "<Leader>gdh", "<cmd>DiffviewFileHistory<CR>",   desc = "Commits history" },
      { "<Leader>gdf", "<cmd>DiffviewFileHistory %<CR>", desc = "THIS Files History" },
      -- all the rest is better done by CodeDiff
      opts = function()
        local actions = require("diffview.actions")
        return {
          enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
          keymaps = {
            view = {
              { "n", "q",         "<cmd>DiffviewClose<CR>" }, -- whats the diff even
              { "n", "<Tab>",     actions.select_next_entry },
              { "n", "<S-Tab>",   actions.select_prev_entry },
              { "n", "<Leader>a", actions.focus_files }, -- whats this?
              { "n", "<Leader>f", actions.toggle_files },
            },
            file_panel = {
              { "n", "q",         "<cmd>DiffviewClose<CR>" },
              { "n", "h",         actions.prev_entry },
              { "n", "gf",        actions.goto_file },
              { "n", "sg",        actions.goto_file_split },
              { "n", "<C-r>",     actions.refresh_files },
              { "n", "<Leader>f", actions.toggle_files },
              {
                "n",
                "<leader>co",
                actions.conflict_choose_all("ours"),
                { desc = "Choose conflict --ours" },
              },
              {
                "n",
                "<leader>ct",
                actions.conflict_choose_all("theirs"),
                { desc = "Choose conflict --theirs" },
              },
              {
                "n",
                "<leader>cx",
                actions.conflict_choose_all("base"),
                { desc = "Choose conflict DISCARD ALL. Keep base" },
              },
              { "n", "s",     actions.toggle_stage_entry, { desc = "Stage/unstage the selected entry" } },
              { "n", "S",     actions.stage_all,          { desc = "Stage all entries" } },
              { "n", "U",     actions.unstage_all,        { desc = "Unstage all entries" } },
              { "n", "<C-p>", actions.prev_conflict,      { desc = "Go to prev conflict" } },
              { "n", "<C-n",  actions.next_conflict,      { desc = "Go to next conflict" } },
            },
            file_history_panel = {
              { "n", "q", "<cmd>DiffviewClose<CR>" },
              { "n", "o", actions.focus_entry },
              { "n", "O", actions.options },
            },
          },
        }
      end,
    },
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",  -- required
        "sindrets/diffview.nvim", -- optional - Diff integration
      },
      event = "VeryLazy",
      config = function()
        local neogit = require("neogit")
        vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "NEOGIT" })
      end,
    },
    {
      -- experimental plugin. looks cool af but not yet as powerful as diffview.
      -- switch to it when its good enough
      -- the main hindrance is that neogit doesn't integrate with it
      -- the other annoying hindrance is breadcrumbs
      -- another thing is that diffview has g? to show help and this doesn't
      "esmuellert/codediff.nvim",
      dependencies = { "MunifTanjim/nui.nvim" },
      cmd = "CodeDiff",
      keys = {
        { "<Leader>gdo", "<cmd>CodeDiff<CR>", desc = "Current changes" },
      },
    },
    opts = { explorer = { view_mode = "tree" }, } -- change with "i" keybind
  }
}
return M
