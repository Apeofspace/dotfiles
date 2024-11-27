-- TBH this isn't great
-- FIX: for some reason when opening this terminal the echo $TERM shows wrong terminal
local M = {
	{
		-- https://github.com/akinsho/toggleterm.nvim
		"akinsho/toggleterm.nvim", -- for smart terminal
		enabled = true,
		version = "*",
		lazy = true,
		keys = {
			{ "<leader>tt", ":ToggleTerm size=15<cr>", desc = "Toggle [T]erm" },
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
        direction = 'float',
				-- direction can be 'vertical' | 'horizontal' | 'tab' | 'float',
				on_open = function(term)
					vim.cmd("startinsert!")
					vim.keymap.set("t", "<ESC>", "<cmd>close<CR>", { buffer = term.bufnr, desc = "Toggle [T]erm" })
				end,
			})
		end,
	},
}

return M
