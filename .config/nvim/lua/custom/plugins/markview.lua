-- https://github.com/OXY2DEV/markview.nvim
return {
	{
		"OXY2DEV/markview.nvim",
		lazy = true,
		ft = "markdown",

		dependencies = {
			-- You may not need this if you don't lazy load
			-- Or if the parsers are in your $RUNTIMEPATH
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			vim.keymap.set("n", "<leader>tm", ":Markview toggleAll<CR>", { desc = "[T]oggle [M]arkview" }),
		},
	},
}
