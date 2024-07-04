return {
	{
		"stevearc/oil.nvim",
		lazy = true,
		cmd = "Oil",
		event = { "VimEnter */*,.*", "BufNew */*,.*" },
		opts = { show_hidden = true },
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
		keys = {
			-- this works with lazy loading, while normal keymapping doesn't
			{ "<leader>oi", "<CMD>Oil<CR>", { desc = "Open parent directory" } },
		},
	},
}
