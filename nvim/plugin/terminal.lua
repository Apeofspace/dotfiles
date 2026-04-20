vim.schedule(function()
  vim.pack.add({ "https://github.com/ruicsh/termite.nvim" })
  require("termite").setup({})
end)

-- Mode 	Key 	Action
-- Terminal 	<C-\> 	Toggle all terminals (smart: focus back)
-- Terminal 	<C-t> 	Create new terminal
-- Terminal 	<C-n> 	Focus next terminal
-- Terminal 	<C-p> 	Focus previous terminal
-- Terminal 	<C-e> 	Focus editor window
-- Terminal 	<C-[> 	Exit to normal mode
-- Terminal 	<C-z> 	Maximize/restore terminal
-- Normal 	q 	Close current terminal
--
-- Additionally, toggle and create keymaps are available in normal mode globally:
-- Mode 	Key 	Action
-- Normal 	<C-\> 	Toggle all terminals (smart: focus back)
-- Normal 	<C-t> 	Create new terminal
