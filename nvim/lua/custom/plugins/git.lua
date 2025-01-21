local M = {
	{
		"sindrets/diffview.nvim",
		enabled = true,
		cmd = { "DiffviewOpen", "DiffviewFileHistory" },
		keys = {
			{ "<Leader>gdf", "<cmd>DiffviewFileHistory %<CR>", desc = "Diff THIS File History" },
			{ "<Leader>gdh", "<cmd>DiffviewFileHistory<CR>", desc = "Diff commits" },
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
						-- { "n", "q", actions.close },
						{ "n", "q", "<cmd>DiffviewClose<CR>" }, -- whats the diff even
						{ "n", "<Tab>", actions.select_next_entry },
						{ "n", "<S-Tab>", actions.select_prev_entry },
						{ "n", "<Leader>a", actions.focus_files }, -- whats this?
						{ "n", "<Leader>f", actions.toggle_files },
					},
					file_panel = {
						-- { "n", "q", actions.close },
						{ "n", "q", "<cmd>DiffviewClose<CR>" },
						{ "n", "h", actions.prev_entry },
						{ "n", "gf", actions.goto_file },
						{ "n", "sg", actions.goto_file_split },
						{ "n", "<C-r>", actions.refresh_files },
						{ "n", "<Leader>f", actions.toggle_files },
						{
							"n",
							"<leader>gdco",
							actions.conflict_choose_all("ours"),
							{ desc = "Choose conflict --ours" },
						},
						{
							"n",
							"<leader>gdct",
							actions.conflict_choose_all("theirs"),
							{ desc = "Choose conflict --theirs" },
						},
						{
							"n",
							"<leader>gdcb",
							actions.conflict_choose_all("base"),
							{ desc = "Choose conflict --base" },
						},
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
	{
		"isakbm/gitgraph.nvim",
		opts = {
			symbols = {
				merge_commit = "M",
				commit = "*",
			},
			format = {
				timestamp = "%H:%M:%S %d-%m-%Y",
				fields = { "hash", "timestamp", "author", "branch_name", "tag" },
			},
			hooks = {
				-- Check diff of a commit
				on_select_commit = function(commit)
					vim.notify("DiffviewOpen " .. commit.hash .. "^!")
					vim.cmd(":DiffviewOpen " .. commit.hash .. "^!")
				end,
				-- Check diff from commit a -> commit b
				on_select_range_commit = function(from, to)
					vim.notify("DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
					vim.cmd(":DiffviewOpen " .. from.hash .. "~1.." .. to.hash)
				end,
			},
		},
		keys = {
			{
				"<leader>gl",
				function()
					require("gitgraph").draw({}, { all = true, max_count = 5000 })
				end,
				desc = "GitGraph - Draw",
			},
		},
	},
	{
		"tpope/vim-fugitive",
		enabled = false,
		config = function()
			vim.keymap.set("n", "<leader>gdf", function()
				local word = vim.fn.input("SHA > ")
				if not (word == nil or word == "") then
					vim.cmd(":vsplit")
					vim.cmd(string.format(":Gedit %s:%%", word))
				end
			end, { desc = "Diff with FUGITIVE" })

			local fugg = vim.api.nvim_create_augroup("fugg", {})
			local autocmd = vim.api.nvim_create_autocmd
			autocmd("BufWinEnter", {
				group = fugg,
				pattern = "*",
				callback = function()
					if vim.bo.ft ~= "fugitive" then -- Emperor bless this plugin
						return
					end
					local bufnr = vim.api.nvim_get_current_buf()
					local opts = { buffer = bufnr, remap = false } -- current buffer only

					-- q out
					vim.keymap.set("n", "q", ":q<CR>", opts)

					-- push
					vim.keymap.set("n", "<leader>p", function()
						vim.cmd.Git("push")
					end, opts, { desc = "Fugitive Push" })

					-- rebase always
					vim.keymap.set("n", "<leader>P", function()
						vim.cmd.Git({ "pull", "--rebase" })
					end, opts, { desc = "Fugitive Pull rebase" })

					-- log 10
					vim.keymap.set(
						"n",
						"<leader>gl",
						":Git log -10 --oneline --all<CR>",
						opts,
						{ desc = "Fugitive Git Log -10" }
					)
					-- vim.keymap.set('n', function()
					--   vim.cmd.Git.log()
					-- end)
				end,
			})
		end,
	},
}
return M
