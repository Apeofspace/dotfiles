M = {
	"folke/persistence.nvim",
	event = "BufReadPre", -- this will only start session saving when an actual file was opened
	opts = {
		autoload = true,
	},
	keys = {
		{
			"<leader>os",
			function()
				require("persistence").select()
			end,
			desc = "List Sessions",
		},
		{
			"<leader>ol",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Restore Last Session",
		},
		{
			"<leader>od",
			function()
				require("persistence").stop()
			end,
			desc = "Don't Save Current Session",
		},
	},
	init = function()
		-- autoload current dir session
		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			nested = true,
			callback = function()
				require("persistence").load()
			end,
		})
	end,
}

return M
