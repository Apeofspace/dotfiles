return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Better Around/Inside textobjects
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			require("mini.surround").setup()

			-- local function gethomedir()
			-- 	if vim.loop.os_uname().sysname == "Windows" or vim.loop.os_uname().sysname == "Windows_NT" then
			-- 		return os.getenv("HOMEPATH")
			-- 	elseif vim.loop.os_uname().sysname == "Linux" then
			-- 		return os.getenv("HOME")
			-- 	end
			-- end
			-- require("mini.sessions").setup({
			-- 	autoread = true,
			-- 	autowrite = true,
			-- 	-- directory = os.getenv("HOME") .. "/.nvim/minisesh",
			-- 	directory = gethomedir() .. "/.nvim/minisesh",
			-- })

			require("mini.diff").setup({
				view = {
					style = "sign",
					signs = {
						add = "+",
						change = "~",
						delete = "_",
						topdelete = "‾",
						changedelete = "~",
					},
				},
			})
			vim.keymap.set("n", "<leader>to", function()
				vim.cmd("lua MiniDiff.toggle_overlay()")
			end, { desc = "Toggle mini.diff overlay" })

			-- move selection
			require("mini.move").setup()

			-- file navigation
			require("mini.files").setup({
				vim.keymap.set("n", "<leader>oi", "<CMD>lua MiniFiles.open()<CR>", { desc = "Find files" }),
			})

			-- highlight patterns
			local hipatterns = require("mini.hipatterns")
			hipatterns.setup({
				highlighters = {
					-- Highlight standalone 'FIXME', 'HACK', 'TODO', 'NOTE'
					fixme = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
					hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
					todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
					note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
					warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsHack" },

					-- Highlight hex color strings (`#rrggbb`) using that color
					hex_color = hipatterns.gen_highlighter.hex_color(),
				},
			})

			-- make fFtT work between lines
			require("mini.jump").setup()
		end,
	},
}
