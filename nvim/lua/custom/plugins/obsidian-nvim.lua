local M = {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	cmd = { "ObsidianSearch", "ObsidianTags", "ObsidianNew" },
	keys = {
		{ "<leader>oo", ":ObsidianSearch<CR>", desc = "[O]bsidian [V]ault" },
		{ "<leader>ot", ":ObsidianTags<CR>", desc = "[O]bsidian [T]ags" },
	},
	ft = "markdown",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		-- "hrsh7th/nvim-cmp",
	},
	init = function()
		vim.opt.conceallevel = 1
	end,
	opts = {
		workspaces = {
			-- {
			-- 	name = "nvim only",
			-- 	path = "~/proj/obsidian_vault/",
			-- },
			{
				name = "main",
				path = "~/Documents/Obsidian Vault",
			},
		},
		--Optional, customize how note file names are generated given the ID, target directory, and title.
		--@param spec { id: string, dir: obsidian.Path, title: string|? }
		--@return string|obsidian.Path The full path to the new note.
		note_path_func = function(spec)
			local path = spec.dir / tostring(spec.title)
			return path:with_suffix(".md")
		end,
		disable_frontmatter = true,
	},
}

return M
