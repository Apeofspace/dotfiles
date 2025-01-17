return {
	"j-hui/fidget.nvim",
	enabled = true,
	event = 'LspAttach',
	config = function()
		local fidget = require("fidget")
		fidget.setup({
			notification = {
				override_vim_notify = true, -- Automatically override vim.notify() with Fidget
			},
		})
	end,
}
