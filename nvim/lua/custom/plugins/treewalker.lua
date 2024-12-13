local M

M = {
	{
		"aaronik/treewalker.nvim",
		config = function()
			local tw = require("treewalker")
			tw.setup({
				highlight = true, -- default is false
			})
			vim.api.nvim_set_keymap("n", "<C-j>", ":Treewalker Down<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<C-k>", ":Treewalker Up<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<C-h>", ":Treewalker Left<CR>", { noremap = true })
			vim.api.nvim_set_keymap("n", "<C-l>", ":Treewalker Right<CR>", { noremap = true })
		end,
	},
}

return M
