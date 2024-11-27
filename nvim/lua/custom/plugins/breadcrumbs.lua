local M = {
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
    -- config = function ()
    --   require("nvim-web-devicons").setup()
    --   require("barbecue").setup()
    -- end
		opts = { },
	},
}

return M
