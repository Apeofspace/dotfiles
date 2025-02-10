local M = {
	{
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
			-- "nvim-telescope/telescope.nvim",
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
	},
	{
		"OXY2DEV/markview.nvim",
		enabled = false,
		lazy = false, -- Recommended
		-- ft = "markdown" -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		-- enabled = false,
		dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
		ft = "markdown",
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
}

-- Enable soft word wrap for Markdown files
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.wrap = true -- Enable line wrapping
		vim.opt_local.linebreak = true -- Wrap at word boundaries, not in the middle of a word
		vim.opt_local.breakindent = true -- Indent wrapped lines to align with the start of the text
		vim.opt_local.textwidth = 80
		vim.opt_local.conceallevel = 2
		vim.opt.spell = true
	end,
})

return M
