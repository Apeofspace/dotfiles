-- TODO huge idea here.
-- make a git sync by hand that automatically pulls data from git and pushes 
-- every time you save a file.
-- the challenge here will be to resolve merge commits

-- change to this https://github.com/obsidian-nvim/obsidian.nvim 

local M = {
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		dependencies = {
			"nvim-lua/plenary.nvim",
			"folke/snacks.nvim",
		},
		lazy = true,
		cmd = { "ObsidianSearch", "ObsidianTags", "ObsidianNew" },
		ft = "markdown",
		keys = {
			{ "<leader>oo", ":ObsidianQuickSwitch<CR>", desc = "[O]bsidian [Q]uick [S]witch" },
			{ "<leader>os", ":ObsidianSearch<CR>", desc = "[O]bsidian [V]ault" },
			{ "<leader>ot", ":ObsidianTags<CR>", desc = "[O]bsidian [T]ags" },
			{
				"<leader>on",
				function()
					vim.ui.input({ prompt = "New obsidian note: " }, function(input)
						if input and input ~= "" then
							vim.cmd("ObsidianNew " .. input)
						else
							vim.notify("Note not create: name empty", vim.log.levels.WARN)
						end
					end)
				end,
				desc = "[O]bsidian [N]ew",
			},
		},
		init = function()
			vim.opt.conceallevel = 2
		end,
		opts = {
			workspaces = {
				{
					name = "main",
					path = "~/Documents/Obsidian Vault",
				},
			},
			note_path_func = function(spec)
				local path = spec.dir / tostring(spec.title)
				return path:with_suffix(".md")
			end,
			disable_frontmatter = true,
		},
	},
	{
		"OXY2DEV/markview.nvim",
		-- enabled = false,
		-- lazy = false, -- Recommended
		ft = "markdown", -- If you decide to lazy-load anyway

		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-tree/nvim-web-devicons",
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		enabled = false,
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
		vim.opt_local.conceallevel = 2 -- i don't think it cares
		-- vim.opt.spell = true
	end,
})

return M
