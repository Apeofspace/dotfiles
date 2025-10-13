-- https://github.com/MunsMan/kitty-navigator.nvim
return {
  {
    -- NOTE this bind ctrl keys by default
    "MunsMan/kitty-navigator.nvim",
    opts = { keybindings = {}, },
  }
}


-- --pane navigation (for kitty nvim integration)
-- vim.keymap.set({ "n", "v", "x" }, "<C-h>", "<C-w>h")
-- vim.keymap.set({ "n", "v", "x" }, "<C-j>", "<C-w>j")
-- vim.keymap.set({ "n", "v", "x" }, "<C-k>", "<C-w>k")
-- vim.keymap.set({ "n", "v", "x" }, "<C-l>", "<C-w>l")
