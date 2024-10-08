return {
	"epwalsh/obsidian.nvim",
	version = "*", -- recommended, use latest release instead of latest commit
	lazy = true,
	keys = {
		{ "<leader>ov", desc = "[O]bsidian [V]ault" },
		{ "<leader>ot", desc = "[O]bsidian [T]ags" },
		{ "<leader>on", desc = "[O]bsidian [N]ew" },
	},
	enabled = true,
	-- ft = "markdown",
	-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
	-- event = {
	--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
	--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
	--   "BufReadPre path/to/my-vault/**.md",
	--   "BufNewFile path/to/my-vault/**.md",
	-- },
	dependencies = {
		-- Required.
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("obsidian").setup({
			workspaces = {
				{
					name = "work",
					path = "~/Documents/Obsidian Vault",
				},
			},
			mappings = {
				-- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
				["gf"] = {
					action = function()
						return require("obsidian").util.gf_passthrough()
					end,
					opts = { noremap = false, expr = true, buffer = true },
				},
				-- Toggle check-boxes.
				["<leader>ch"] = {
					action = function()
						return require("obsidian").util.toggle_checkbox()
					end,
					opts = { buffer = true },
				},
				-- Smart action depending on context, either follow link or toggle checkbox.
				-- ["<cr>"] = {
				-- 	action = function()
				-- 		return require("obsidian").util.smart_action()
				-- 	end,
				-- 	opts = { buffer = true, expr = true },
				-- },
			},
			vim.keymap.set("n", "<leader>ov", ":ObsidianSearch<CR>", { desc = "[O]bsidian [V]ault" }),
			vim.keymap.set("n", "<leader>ot", ":ObsidianTags<CR>", { desc = "[O]bsidian [T]ags" }),
			vim.keymap.set("n", "<leader>on", function()
				local word = vim.fn.input("New note name: > ")
				if not (word == nil or word == "") then
					vim.cmd(string.format(":ObsidianNew %s", word))
					-- this doesn't work how i want
				end
			end, { desc = "[O]bsidian [N]ew" }),
		})
	end,
	picker = {
		-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
		name = "telescope.nvim",
		-- Optional, configure key mappings for the picker. These are the defaults.
		-- Not all pickers support all mappings.
		note_mappings = {
			-- Create a new note from your query.
			new = "<C-x>",
			-- Insert a link to the selected note.
			insert_link = "<C-l>",
		},
		tag_mappings = {
			-- Add tag(s) to current note.
			tag_note = "<C-x>",
			-- Insert a tag at the current location.
			insert_tag = "<C-l>",
		},
	},
}
