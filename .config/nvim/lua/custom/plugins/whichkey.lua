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
	{ -- Useful plugin to show you pending keybinds.
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		config = function() -- This is the function that runs, AFTER loading
			require("which-key").setup()

			-- Document existing key chains
			require("which-key").add({
				{ "<leader>c", group = "[C]ode" },
				{ "<leader>d", group = "[D]ocument" },
				{ "<leader>r", group = "[R]ename" },
				{ "<leader>s", group = "[S]earch" },
				{ "<leader>w", group = "[W]orkspace" },
				{ "<leader>t", group = "[T]oggle" },
				{ "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
			})
		end,
	},
}
