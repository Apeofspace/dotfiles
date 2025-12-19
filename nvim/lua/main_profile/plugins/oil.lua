return {
  "stevearc/oil.nvim",
  opts = {
    delete_to_trash = true,
    view_options = { show_hidden = true, },
    float = {
      padding = 2,
      max_width = 90,
      max_height = 40,
      border = "rounded",
      win_options = { winblend = 15, },
    },
    keymaps = { ["q"] = { "actions.close", mode = "n" }, },
    vim.keymap.set("n", "<leader>oi", function() require("oil").open_float() end, { desc = "[O]il" })
  },
}

--
-- return {
--   {
--     "A7Lavinraj/fyler.nvim",
--     dependencies = { "nvim-mini/mini.icons" },
--     branch = "stable",
--     config = function()
--       local fyler = require("fyler")
--       fyler.setup({
--         mappings = {
--           -- I hate these
--           ["q"] = "CloseView",
--           ["<CR>"] = "Select",
--           ["-"] = "GotoParent",
--           ["="] = "GotoCwd",
--           ["<C-t>"] = nil,
--           ["|"] = nil,
--           ["^"] = nil,
--           ["."] = nil,
--           ["#"] = nil,
--           ["<BS>"] = "CollapseNode",
--         }
--       })
--       vim.keymap.set("n", "<leader>oi", ":Fyler kind=float<CR>", { desc = "Fyler" })
--     end,
--   }
-- }
