-- the only thing it does is autoinstalls treesitter packs
local M = {
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
}
return M
