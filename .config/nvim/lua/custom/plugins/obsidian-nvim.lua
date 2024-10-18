local M = {
	-- NOTE this plugin just straight up sucks. it doesn't work  the way i want
	-- and config is way too difficult
	"epwalsh/obsidian.nvim",
	enabled = true,
	version = "*", -- recommended, use latest release instead of latest commit
	cmd = { "ObsidianSearch", "ObsidianTags", "ObsidianNew" },
	keys = {
		{ "<leader>ov", ":ObsidianSearch<CR>", desc = "[O]bsidian [V]ault" },
		{ "<leader>ot", ":ObsidianTags<CR>", desc = "[O]bsidian [T]ags" },
		{
			"<leader>on",
			function()
				local word = vim.fn.input("New note name: > ")
				if not (word == nil or word == "") then
					vim.cmd(string.format(":ObsidianNew %s", word))
					-- this doesn't work how i want
				end
			end,
			desc = "[O]bsidian [N]ew",
		},
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
	config = function()
		require("obsidian").setup({
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
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					-- stylua: ignore
					action = function() return require("obsidian").util.gf_passthrough() end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ch"] = {
					-- stylua: ignore
					action = function() return require("obsidian").util.toggle_checkbox() end,
					opts = { buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				["<cr>"] = {
					-- stylua: ignore
					action = function() return require("obsidian").util.smart_action() end,
					opts = { buffer = true, expr = true },
				},
			},
		})
	end,
	ui = {
		enable = true, -- set to false to disable all additional syntax features
		update_debounce = 200, -- update delay after a text change (in milliseconds)
		-- Define how various check-boxes are displayed
		checkboxes = {
			-- NOTE: the 'char' value has to be a single character, and the highlight groups are defined below.
			[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
			["x"] = { char = "", hl_group = "ObsidianDone" },
			[">"] = { char = "", hl_group = "ObsidianRightArrow" },
			["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
			-- Replace the above with this if you don't have a patched font:
			-- [" "] = { char = "☐", hl_group = "ObsidianTodo" },
			-- ["x"] = { char = "✔", hl_group = "ObsidianDone" },

			-- You can also add more custom ones...
		},
		external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		-- Replace the above with this if you don't have a patched font:
		-- external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },
		reference_text = { hl_group = "ObsidianRefText" },
		highlight_text = { hl_group = "ObsidianHighlightText" },
		tags = { hl_group = "ObsidianTag" },
		hl_groups = {
			-- The options are passed directly to `vim.api.nvim_set_hl()`. See `:help nvim_set_hl`.
			ObsidianTodo = { bold = true, fg = "#f78c6c" },
			ObsidianDone = { bold = true, fg = "#89ddff" },
			ObsidianRightArrow = { bold = true, fg = "#f78c6c" },
			ObsidianTilde = { bold = true, fg = "#ff5370" },
			ObsidianRefText = { underline = true, fg = "#c792ea" },
			ObsidianExtLinkIcon = { fg = "#c792ea" },
			ObsidianTag = { italic = true, fg = "#89ddff" },
			ObsidianHighlightText = { bg = "#75662e" },
		},
	},
	follow_url_func = function(url)
		-- vim.fn.jobstart({ "xdg-open", url }) -- linux
		vim.ui.open(url) -- need Neovim 0.10.0+
	end,
	follow_img_func = function(img)
		vim.fn.jobstart({ "xdg-open", img }) -- linux
	end,
	disable_frontmatter = true, -- frontmatter is aliases, tags etc
	note_frontmatter_func = function(note)
		if note.title then
			note:add_alias(note.title)
		end
		local out = { id = note.id, aliases = note.aliases, tags = note.tags }
		-- ensure fields are kept in the frontmatter
		if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
			for k, v in pairs(note.metadata) do
				out[k] = v
			end
		end
		return out
	end,
	note_id_func = function(title)
		-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
		-- In this case a note with the title 'My new note' will be given an ID that looks
		-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
		local suffix = ""
		if title ~= nil then
			-- If title is given, transform it into valid file name.
			suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
		else
			-- If title is nil, just add 4 random uppercase letters to the suffix.
			for _ = 1, 4 do
				suffix = suffix .. string.char(math.random(65, 90))
			end
		end
		return tostring(os.time()) .. "-" .. suffix
	end,
	picker = {
		-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
		name = "telescope.nvim",
		-- note_mappings = {
		-- 	new = "<C-x>",
		-- 	insert_link = "<C-l>",
		-- },
		-- tag_mappings = {
		-- 	tag_note = "<C-x>",
		-- 	insert_tag = "<C-l>",
		-- },
		sort_by = "modified",
		sort_reversed = true,
		search_max_lines = 1000,
		open_notes_in = "current", -- vsplit|hsplit
	},
}

return M
