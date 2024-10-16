local M = {
	{
		"sindrets/diffview.nvim",
		enabled = true,
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<Leader>gdh", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff File History" },
			{ "<Leader>gdc", "<cmd>DiffviewOpen HEAD<CR>", desc = "Diff View latest commit" },
			{ "<Leader>gdo", "<cmd>DiffviewOpen<CR>", desc = "Diff View Open (hangs =( ...)))" },
		},
		opts = function()
			local actions = require("diffview.actions")
			vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
				group = vim.api.nvim_create_augroup("rafi_diffview", {}),
				pattern = "diffview:///panels/*",
				callback = function()
					vim.opt_local.cursorline = true
					vim.opt_local.winhighlight = "CursorLine:WildMenu"
				end,
			})
			return {
				enhanced_diff_hl = true, -- See ':h diffview-config-enhanced_diff_hl'
				keymaps = {
					view = {
						{ "n", "q", actions.close },
						-- { "n", "q", "<cmd>DiffviewClose<CR>" }, -- whats the diff even
						{ "n", "<Tab>", actions.select_next_entry },
						{ "n", "<S-Tab>", actions.select_prev_entry },
						{ "n", "<Leader>a", actions.focus_files }, -- whats this?
						{ "n", "<Leader>f", actions.toggle_files },
					},
					file_panel = {
						{ "n", "q", actions.close },
						{ "n", "h", actions.prev_entry },
						{ "n", "gf", actions.goto_file },
						{ "n", "sg", actions.goto_file_split },
						{ "n", "<C-r>", actions.refresh_files },
						{ "n", "<Leader>f", actions.toggle_files },
						{ "n", "co", actions.conflict_choose_all("ours"), { desc = "Choose conflict --ours" } },
						{ "n", "ct", actions.conflict_choose_all("theirs"), { desc = "Choose conflict --theirs" } },
						{ "n", "cb", actions.conflict_choose_all("base"), { desc = "Choose conflict --base" } },
						{ "n", "s", actions.toggle_stage_entry, { desc = "Stage/unstage the selected entry" } },
						{ "n", "S", actions.stage_all, { desc = "Stage all entries" } },
						{ "n", "U", actions.unstage_all, { desc = "Unstage all entries" } },
						{ "n", "<C-p>", actions.prev_conflict, { desc = "Go to prev conflict" } },
						{ "n", "<C-n", actions.next_conflict, { desc = "Go to next conflict" } },
					},
					file_history_panel = {
						{ "n", "q", "<cmd>DiffviewClose<CR>" },
						{ "n", "o", actions.focus_entry },
						{ "n", "O", actions.options },
					},
				},
			}
		end,
		-- Examples:
		-- :DiffviewOpen
		-- :DiffviewOpen HEAD~2
		-- :DiffviewOpen HEAD~4..HEAD~2
		-- :DiffviewOpen d4a7b0d
		-- :DiffviewOpen d4a7b0d^!
		-- :DiffviewOpen d4a7b0d..519b30e
		-- :DiffviewOpen origin/main...HEAD
	},
}

return M
