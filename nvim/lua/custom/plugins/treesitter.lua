return {
	{ -- Highlight, edit, and navigate code
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			-- [[ Configure Treesitter ]] See `:help nvim-treesitter`

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
				-- Autoinstall languages that are not installed
				auto_install = true,
				sync_install = true,
				highlight = { enable = true },
				indent = { enable = true },
			})

			-- There are additional nvim-treesitter modules that you can use to interact
			-- with nvim-treesitter. You should go explore a few and see what interests you:
			--
			--    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
			--    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
			--    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
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
			vim.keymap.set({ "n", "v" }, "<leader>h", ":Treewalker Left<CR>", { noremap = true })
			vim.keymap.set({ "n", "v" }, "<leader>j", ":Treewalker Down<CR>", { noremap = true })
			vim.keymap.set({ "n", "v" }, "<leader>k", ":Treewalker Up<CR>", { noremap = true })
			vim.keymap.set({ "n", "v" }, "<leader>l", ":Treewalker Right<CR>", { noremap = true })
		end,
	},
}
