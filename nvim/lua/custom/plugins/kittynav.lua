-- --pane navigation (for kitty nvim integration)
-- vim.keymap.set({ "n", "v", "x" }, "<C-h>", "<C-w>h")
-- vim.keymap.set({ "n", "v", "x" }, "<C-j>", "<C-w>j")
-- vim.keymap.set({ "n", "v", "x" }, "<C-k>", "<C-w>k")
-- vim.keymap.set({ "n", "v", "x" }, "<C-l>", "<C-w>l")

-- keys = {
--   { "<C-h>", function() require("kitty-navigator").navigateLeft() end, desc = "Move left a Split", mode = { "n" } },
--   { "<C-j>", function() require("kitty-navigator").navigateDown() end, desc = "Move down a Split", mode = { "n" } },
--   { "<C-k>", function() require("kitty-navigator").navigateUp() end,  desc = "Move up a Split",    mode = { "n" } },
--   { "<C-l>", function() require("kitty-navigator").navigateRight() end, desc = "Move right a Split", mode = { "n" } },
-- },
return {
  -- https://github.com/MunsMan/kitty-navigator.nvim
  {
    "MunsMan/kitty-navigator.nvim",
    build = {
      "cp navigate_kitty.py ~/.config/kitty",
      "cp pass_keys.py ~/.config/kitty",
    },
    opts = { keybindings = {} },
  }
}
