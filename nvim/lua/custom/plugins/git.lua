local function complete_branches(arg_lead, cmd_line, cursor_pos)
	local branches = vim.fn.systemlist('git branch --format="%(refname:short)"')
	local matches = {}
	for _, branch in ipairs(branches) do
		if branch:match("^" .. arg_lead) then
			table.insert(matches, branch)
		end
	end
	return matches
end
vim.g.complete_branches = complete_branches -- expose to global namespace

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
			{
				"<Leader>gdb",
				-- it seems that vim.ui.input doesnt support completion yet
				-- function()
				-- 	vim.ui.input({
				-- 		prompt = "Branch to compare HEAD to: ",
				-- 		completion = "customlist",
				-- 		completion_list = complete_branches,
				-- 	}, function(input)
				-- 		if input and input ~= "" then
				-- 			vim.cmd("DiffviewOpen HEAD.." .. input)
				-- 		end
				-- 	end)
				-- end,
				function()
					local branch = vim.fn.input("Branch to compare HEAD to: ", "", "customlist,complete_branches")
					if branch and branch ~= "" then
						vim.cmd("DiffviewOpen HEAD.." .. branch)
					end
				end,
				desc = "Compare current branch to ...",
			},
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
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration
			-- Only one of these is needed.
			-- "nvim-telescope/telescope.nvim", -- optional
		},
		event = "VeryLazy",
		-- config = true,
		config = function()
			local neogit = require("neogit")
			vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "NEOGIT" })
		end,
	},
}
return M
