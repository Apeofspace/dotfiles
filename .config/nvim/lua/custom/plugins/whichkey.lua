-- Useful plugin to show you pending keybinds.
-- return {
-- 	{
-- 		"folke/which-key.nvim",
-- 		event = "VimEnter", -- Sets the loading event to 'VimEnter'
-- 		config = function() -- This is the function that runs, AFTER loading
-- 			require("which-key").setup()
-- 			-- Document existing key chains
-- 			require("which-key").register({
-- 				{ "<leader>c", group = "[C]ode" },
-- 				{ "<leader>c_", hidden = true },
-- 				{ "<leader>d", group = "[D]ocument" },
-- 				{ "<leader>d_", hidden = true },
-- 				{ "<leader>s", group = "[S]earch" },
-- 				{ "<leader>s_", hidden = true },
-- 			})
-- 		end,
-- 	},
-- }

return {
	{
		"folke/which-key.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>c_", hidden = true },
			{ "<leader>d", group = "[D]ocument" },
			{ "<leader>d_", hidden = true },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>s_", hidden = true },
		},
	},
}
