return {
	"sindrets/diffview.nvim",
	opts = {
		view = {
			file_panel = {
				win_config = {
					position = "left",
				},
			},
		},
		vim.keymap.set("n", "<leader>tdc", ":DiffviewOpen<CR>", { desc = "Compare current file against indexed" }),
		vim.keymap.set("n", "<leader>tdf", function()
			local word = vim.fn.input("SHA > ") or ""
			vim.cmd(string.format(":DiffviewOpen %s", word))
		end, { desc = "Compare current file against git rev" }),
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
