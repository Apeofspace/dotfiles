local running_neovide = vim.g.neovide
local running_kitty = (vim.env.TERM_PROGRAM or vim.env.TERM) == "xterm-kitty"
local running_wezterm = (vim.env.TERM_PROGRAM or vim.env.TERM) == "WezTerm"
local M = {
	{
		"sphamba/smear-cursor.nvim",
		enabled = not running_neovide and not running_kitty,
		-- enabled = false,
		opts = {},
	},
	{
		"karb94/neoscroll.nvim",
		-- enabled = (not running_neovide) and (not running_wezterm),
		enabled = not running_neovide,
		-- enabled = false,
		config = function()
			local neoscroll = require("neoscroll")
			neoscroll.setup({
				easing = "quadratic",
				performance_mode = false, -- disable treesitter
				hide_cursor = false,
				-- mappings = { "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			})
			-- vim.keymap.set({ "n", "v", "x" }, "<C-u>", neoscroll.scroll(-0.5, {move_cursor=true, duration=1000}))
			-- vim.keymap.set({ "n", "v", "x" }, "<C-d>", neoscroll.scroll(0.5, {move_cursor=true, duration=1000}))
			-- vim.keymap.set({ "n", "v", "x" }, "<C-u>", neoscroll.scroll(-vim.wo.scroll, true, 350))
			-- vim.keymap.set({ "n", "v", "x" }, "<C-d>", neoscroll.scroll(vim.wo.scroll, true, 350))
		end,
	},
}

return M
