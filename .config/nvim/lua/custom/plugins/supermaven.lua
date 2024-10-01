M = {
	"supermaven-inc/supermaven-nvim",
	lazy = true,
	event = { "VeryLazy", "InsertEnter", "CmdlineEnter" },
	config = function()
		require("supermaven-nvim").setup({
			disable_keymaps = true,
			disable_inline_completion = true,
		})
	end,
}

return M
