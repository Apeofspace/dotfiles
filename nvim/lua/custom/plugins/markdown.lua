local vault_path = vim.fn.expand("~/Documents/Obsidian Vault")
local M = {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		keys = {
			{ "<leader>oo", ":ObsidianQuickSwitch<CR>", desc = "[O]bsidian [Q]uick [S]witch" },
			{
				"<leader>os",
				function()
					Snacks.picker.pick("grep", {
						cwd = vault_path,
						actions = {
							create_note = function(picker, item)
								picker:close()
								vim.cmd("ObsidianNew " .. picker.finder.filter.search)
							end,
						},
						win = {
							input = {
								keys = {
									["<c-x>"] = { "create_note", desc = "Create new note", mode = { "i", "n" } },
								},
							},
						},
					})
				end,
			},
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
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required.
			"nvim-treesitter/nvim-treesitter",
			"folke/snacks.nvim",
			"saghen/blink.cmp",
			"OXY2DEV/markview.nvim",
			-- "MeanderingProgrammer/render-markdown.nvim",
		},
		config = function()
			local obsidian = require("obsidian")
			obsidian.setup({
				workspaces = {
					{
						name = "personal",
						path = vault_path,
					},
				},
				completion = { nvim_cmp = false, blink = true },
				disable_frontmatter = true,
				note_path_func = function(spec)
					local path = spec.dir / tostring(spec.title)
					return path:with_suffix(".md")
				end,
			})
		end,
	},
	init = function()
		Auto_git() -- do it once on loading the plugin
	end,
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

function Auto_git()
	-- Set up auto pull and commit
	local group_id = vim.api.nvim_create_augroup("obsidian-git", { clear = true })

	-- Create auto pull on open
	local autopull = function()
		local Job = require("plenary.job")
		vim.notify("Pulling Obsidian notes", vim.log.levels.DEBUG, { title = "Obsidian" })
		Job:new({
			command = "git",
			args = { "pull" },
			on_exit = function(j, return_val)
				if return_val == 0 then
					vim.notify("Pulled Obsidian notes", vim.log.levels.INFO, { title = "Obsidian" })
				else
					vim.notify(
						"Failed to pull Obsidian notes. " .. vim.inspect(j:result()),
						vim.log.levels.ERROR,
						{ title = "Obsidian" }
					)
				end
			end,
		}):start()
	end

	vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
		pattern = vault_path .. "/**",
		callback = autopull,
		group = group_id,
	})

	local Job = require("plenary.job")

	-- Create autocommit on save
	local auto_add = function(next_func)
		return function(ev)
			Job:new({
				command = "git",
				args = { "add", ev.file },
				on_exit = function(add_j, add_return_val)
					if add_return_val ~= 0 then
						vim.notify(
							"Failed to add file to git. " .. vim.inspect(add_j:result()),
							vim.log.levels.ERROR,
							{ title = "Obsidian" }
						)
						return
					end

					if next_func then
						next_func()
					end
				end,
			}):start()
		end
	end

	local auto_commit = function(next_func)
		return function()
			local date_string = os.date("%Y-%m-%d %H:%M:%S")
			Job:new({
				command = "git",
				args = { "commit", "-m", "Auto commit: " .. date_string },
				on_exit = function(commit_j, commit_return_val)
					if commit_return_val ~= 0 then
						vim.notify(
							"Failed to commit file to git. " .. vim.inspect(commit_j:result()),
							vim.log.levels.ERROR,
							{ title = "Obsidian" }
						)
						return
					end
					if next_func then
						next_func()
					end
				end,
			}):start()
		end
	end

	local auto_push = function(next_func)
		return function()
			Job:new({
				command = "git",
				args = { "push" },
				on_exit = function(push_j, push_return_val)
					if push_return_val ~= 0 then
						vim.notify(
							"Failed to push Obsidian notes. " .. vim.inspect(push_j:result()),
							vim.log.levels.ERROR,
							{ title = "Obsidian" }
						)
					end

					if next_func then
						next_func()
					end
				end,
			}):start()
		end
	end

	vim.api.nvim_create_autocmd({ "BufWritePost" }, {
		pattern = vault_path .. "/**",
		callback = auto_add(auto_commit(auto_push())),
		group = group_id,
	})
end

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
