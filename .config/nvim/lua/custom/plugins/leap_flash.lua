M = {
	{
		"ggandor/leap.nvim",
		enabled = false,
		config = function()
			local leap = require("leap")
			leap.setup({})
			vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)")
			vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)")
			vim.keymap.set({ "n", "x", "o" }, "gt", "<Plug>(leap-from-window)")
		end,
	},
	{
		"folke/flash.nvim",
		enabled = false,
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"t",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"T",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			-- {
			-- 	"<c-s>",
			-- 	mode = { "c" },
			-- 	function()
			-- 		require("flash").toggle()
			-- 	end,
			-- 	desc = "Toggle Flash Search",
			-- },
		},
	},
}

return M
