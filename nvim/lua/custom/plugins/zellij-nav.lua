-- this plugin was unfinished at the time of installation 28.11.24
-- it doesn't allow forwarding inputs to neovim, therefore doesn't let neovim
-- nav keys to be the same as zellij nav keys. Disabled until fix
-- When its fixed, change mini.move hotkeys or zellij nav hotkeys, as they are
-- conflicting

-- A way around it is using unlocked mode everywhere but nvim, and have nvim
-- autolock zellij. Then I can have nav keys only work in locked mode.
-- So in nvim i will nav in nvim, and out of nvim it will unlock and nav with
-- zellij

-- https://github.com/swaits/zellij-nav.nvim
-- ALTERNATIVE https://github.com/GR3YH4TT3R93/zellij-nav.nvim

local M = {
	{
		"https://git.sr.ht/~swaits/zellij-nav.nvim",
		enabled = false,
		lazy = true,
		event = "VeryLazy",
		keys = {
			{ "<M-h>", "<cmd>ZellijNavigateLeftTab<cr>", { silent = true, desc = "navigate left or tab" } },
			{ "<M-j>", "<cmd>ZellijNavigateDown<cr>", { silent = true, desc = "navigate down" } },
			{ "<M-k>", "<cmd>ZellijNavigateUp<cr>", { silent = true, desc = "navigate up" } },
			{ "<M-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
		},
		opts = {},
	},
}

return M
