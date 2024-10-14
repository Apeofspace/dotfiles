return {
	"jackMort/tide.nvim",
	enabled = true,
	config = function()
		require("tide").setup({
			-- optional configuration
			keys = {
				leader = "<leader>",
				panel = "<leader>",
				horizonal = "s",
				vertical = "v",
				delete = "x",
				clear_all = "X",
			},
			hints = {
				-- dictionary = "qwertzuiopsfghjklycvbnm",  -- Key hints for quick access
				dictionary = "123456789", -- Key hints for quick access
			},
		})
	end,
	dependencies = {
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
}
