return {
	{
		enabled = false,
		"daliusd/incr.nvim",
		config = true,
	},
	{
		"nvzone/typr",
		enabled = true,
		dependencies = "nvzone/volt",
		opts = {},
		cmd = { "Typr", "TyprStats" },
	},
	{
		"A7Lavinraj/fyler.nvim",
		enabled = false,
		dependencies = { "echasnovski/mini.icons" },
		opts = {},
		init = function()
			-- vim.keymap.set("n", "<leader>ol", vim.cmd("Fyler"), { desc = "Fyler" })
			vim.keymap.set("n", "<leader>ol", ":Fyler kind=float<CR>", { desc = "Fyler" }) -- is float by default tho
		end,
	},
	{
		-- its so beta i couldn't run it
		"alucherdi/hand-of-god",
		enabled = false,
		opts = {},
		init = function()
			vim.keymap.set("n", "<leader>oh", function()
				require("handofgod.manager"):open()
			end)

			vim.keymap.set("n", "<leader>oj", function()
				require("handofgod.searcher"):open()
			end)
		end,
	},
}
