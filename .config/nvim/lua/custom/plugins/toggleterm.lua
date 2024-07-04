-- TBH this isn't great
return {
	-- https://github.com/akinsho/toggleterm.nvim
	"akinsho/toggleterm.nvim", -- for smart terminal
	version = "*",
	lazy = true,
	keys = {
		{ "<leader>t", ":ToggleTerm size=15<cr>", { desc = "Toggle [T]erm" } },
	},
	config = function()
		require("toggleterm").setup({
			shade_terminals = false,
			highlights = {
				StatusLine = { guifg = "#ffffff", guibg = "#0E1018" },
				StatusLineNC = { guifg = "#ffffff", guibg = "#0E1018" },
			},
			hide_numbers = true,
			autochdir = true,
			auto_scroll = true,
			border = "double",
			-- direction can be 'vertical' | 'horizontal' | 'tab' | 'float',
			-- vim.keymap.set({ "n", "v" }, "<leader>t", ":ToggleTerm size=15<cr>", { desc = "Toggle [T]erm" }),
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.keymap.set("t", "<ESC>", "<cmd>close<CR>", { buffer = term.bufnr, desc = "Toggle [T]erm" })
			end,
		})
	end,
}
