return {
	-- this plugin causes hangs
	"sindrets/diffview.nvim",
	lazy = true,
	opts = {
		view = {
			file_panel = {
				win_config = {
					position = "left",
				},
			},
		},
	},
	keys = {
		{ "<leader>gdc", "<cmd>DiffviewOpen<CR>", "n", desc = "Compare current file against indexed" },
		{
			"<leader>gdf",
			function()
				local word = vim.fn.input("SHA > ") or ""
				vim.cmd(string.format("<cmd>DiffviewOpen %s", word))
			end,
			"n",
			desc = "Compare current file against git rev",
		},
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
