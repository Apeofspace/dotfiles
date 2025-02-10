return {
	"stevearc/oil.nvim",
	enabled = true,
	event = "VeryLazy",
	config = function()
		local oil = require("oil")
		oil.setup({
			delete_to_trash = true,
			view_options = {
				-- Show files and directories that start with "."
				show_hidden = true,
			},
			float = {
				-- Padding around the floating window
				padding = 2,
				max_width = 90,
				max_height = 0,
				border = "rounded",
				win_options = {
					winblend = 15,
				},
			},
			-- Optional dependencies
			dependencies = { "nvim-tree/nvim-web-devicons" },
		})
		vim.keymap.set("n", "<leader>oi", function()
			-- oil.open()
			oil.open_float()
			-- oil.open_preview()
		end, { desc = "[O]il" })
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "oil" },
			callback = function()
				vim.keymap.set("n", "q", oil.close, { buffer = true })
			end,
		})
	end,
}
