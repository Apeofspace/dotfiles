local M = {
	"supermaven-inc/supermaven-nvim",
	lazy = true,
	enabled = false,
	event = { "VeryLazy", "InsertEnter", "CmdlineEnter" },
	config = function()
		require("supermaven-nvim").setup({
			disable_keymaps = true,
			disable_inline_completion = true,
		})
	end,
}

return M
