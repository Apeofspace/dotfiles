return {
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		-- event = "VeryLazy", -- if its very lazy it doesnt load side buffer
		enabled = true,
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {},
	},
}
