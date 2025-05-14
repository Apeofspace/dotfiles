local M = {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"c",
					"html",
					"lua",
					"markdown",
					"markdown_inline",
					"vim",
					"vimdoc",
					"python",
					"go",
					"diff",
					"regex",
				},
				auto_install = true,
				sync_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		-- jumping between the matching opposing end of a Tree-sitter node, such as brackets, quotes, and more.
		"yorickpeterse/nvim-tree-pairs",
		enabled = true,
		opts = {},
	},
	{
		"aaronik/treewalker.nvim",
		enabled = false, -- honestly I never use this and it takes nice bindings
		config = function()
			local tw = require("treewalker")
			tw.setup({
				highlight = true, -- default is false
			})
			vim.keymap.set({ "n", "v" }, "<C-h>", ":Treewalker Left<CR>", { noremap = true })
			vim.keymap.set({ "n", "v" }, "<C-j>", ":Treewalker Down<CR>", { noremap = true })
			vim.keymap.set({ "n", "v" }, "<C-k>", ":Treewalker Up<CR>", { noremap = true })
			vim.keymap.set({ "n", "v" }, "<C-l>", ":Treewalker Right<CR>", { noremap = true })
		end,
	},
}
return M
-- return {}
