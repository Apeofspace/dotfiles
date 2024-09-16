return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		enabled = false,
		event = "User ColorschemeLoaded", -- NOTE: uncomment wherever this is emitted
		opts = {},
	},
	{
		-- https://github.com/shellRaining/hlchunk.nvim?tab=readme-ov-file
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				line_num = {
					enable = false,
				},
				chunk = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
}
