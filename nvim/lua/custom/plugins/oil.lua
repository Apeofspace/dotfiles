-- return {
--   "stevearc/oil.nvim",
--   -- enabled = false,
--   -- event = "VeryLazy",
--   config = function()
--     local oil = require("oil")
--     oil.setup({
--       delete_to_trash = true,
--       view_options = {
--         show_hidden = true,
--       },
--       float = {
--         padding = 2,
--         max_width = 90,
--         max_height = 40,
--         border = "rounded",
--         win_options = {
--           winblend = 15,
--         },
--       },
--     })
--     vim.keymap.set("n", "<leader>oi", function()
--       -- oil.open()
--       oil.open_float()
--       -- oil.open_preview()
--     end, { desc = "[O]il" })
--     vim.api.nvim_create_autocmd("FileType", {
--       pattern = { "oil" },
--       callback = function()
--         vim.keymap.set("n", "q", oil.close, { buffer = true })
--       end,
--     })
--   end,
-- }

return {
  {
    "A7Lavinraj/fyler.nvim",
    dependencies = { "nvim-mini/mini.icons" },
    branch = "stable",
    config = function()
      local fyler = require("fyler")
      fyler.setup({
        mappings = {
          -- I hate these
          ["q"] = "CloseView",
          ["<CR>"] = "Select",
          ["-"] = "GotoParent",
          ["="] = "GotoCwd",
          ["<C-t>"] = nil,
          ["|"] = nil,
          ["^"] = nil,
          ["."] = nil,
          ["#"] = nil,
          ["<BS>"] = "CollapseNode",
        }
      })
      vim.keymap.set("n", "<leader>oi", ":Fyler kind=float<CR>", { desc = "Fyler" })
    end,
  }
}
