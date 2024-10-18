-- https://github.com/EvWilson/spelunk.nvim
-- another bookmarks plugin
local M = {
	{
		"EvWilson/spelunk.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		enabled = true,
		opts = {
			base_mappings = {
				toggle = "<leader>`",
				add = "<leader>m",
			},
			window_mappings = {
				cursor_down = "j",
				cursor_up = "k",
				bookmark_down = "<C-j>",
				bookmark_up = "<C-k",
				goto_bookmark = "<CR>",
				delete_bookmark = "d",
				next_stack = "<Tab>",
				previous_stack = "<S-Tab>",
				new_stack = "n",
				delete_stack = "D",
				close = "q",
				help = "h", -- Not rebindable
			},
		},
	},
}

return M
