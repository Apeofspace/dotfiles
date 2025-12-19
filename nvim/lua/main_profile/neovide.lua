if vim.g.neovide then
  vim.keymap.set({ "n", "v" }, "=", "<nop>") -- doesn't help fix the minifiles sync problem

  -- nah i want plugins i need to load them AFTER lazy not before. anyway this suxks
  -- local plugins = {
  --   {
  --     { 'akinsho/toggleterm.nvim', version = "*", opts = { --[[ things you want to change go here]] } }
  --   }
  -- }

  -- return plugins
end
