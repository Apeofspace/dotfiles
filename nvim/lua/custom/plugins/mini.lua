return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Better Around/Inside textobjects
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			require("mini.surround").setup({ mappings = { update_n_lines = "" } })

			-- show git diff and toggle diff overlay
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
				vim.notify("Toggle mini.diff overlay")
			end, { desc = "Toggle mini.diff overlay" })

			-- move selection
			require("mini.move").setup({
				-- 	mappings = {
				-- 		-- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
				-- 		left = "<C-M-h>",
				-- 		right = "<C-M-l>",
				-- 		down = "<C-M-j>",
				-- 		up = "<C-M-k>",
				--
				-- 		-- Move current line in Normal mode
				-- 		line_left = "<C-M-h>",
				-- 		line_right = "<C-M-l>",
				-- 		line_down = "<C-M-j>",
				-- 		line_up = "<C-M-k>",
				-- },
			})

			-- oily file navigation
			require("mini.files").setup({
				vim.keymap.set("n", "<leader>oi", function()
					-- set buffer cwd as mini.files cwd
					local MiniFiles = require("mini.files")
					local _ = MiniFiles.close() or MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
					vim.schedule(function()
						-- vim.defer_fn(function()
						MiniFiles.reveal_cwd()
					end, 30)
				end, { desc = "Find files" }),
				-- vim.keymap.set("n", "<leader>oi", "<CMD>lua MiniFiles.open()<CR>", { desc = "Find files" }),
				options = { use_as_default_explorer = true },
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
			-- require("mini.jump").setup() -- it is useful but looks ugly

			-- show keymaps help
			local miniclue = require("mini.clue")
			miniclue.setup({
				triggers = {
					-- Leader triggers
					{ mode = "n", keys = "<Leader>" },
					{ mode = "x", keys = "<Leader>" },
					-- Built-in completion
					{ mode = "i", keys = "<C-x>" },
					-- `g` key
					{ mode = "n", keys = "g" },

					-- Marks
					{ mode = "n", keys = "'" },
					{ mode = "n", keys = "`" },
					{ mode = "x", keys = "'" },
					{ mode = "x", keys = "`" },
					-- Registers
					{ mode = "n", keys = '"' },
					{ mode = "x", keys = '"' },
					{ mode = "i", keys = "<C-r>" },
					{ mode = "c", keys = "<C-r>" },
					-- Window commands
					{ mode = "n", keys = "<C-w>" },
					{ mode = "n", keys = "<Leader>w" },
					-- `z` key
					{ mode = "n", keys = "z" },
					{ mode = "x", keys = "z" },
				},
				clues = {
					-- Enhance this by adding descriptions for <Leader> mapping groups
					miniclue.gen_clues.builtin_completion(),
					miniclue.gen_clues.g(),
					miniclue.gen_clues.marks(),
					miniclue.gen_clues.registers(),
					miniclue.gen_clues.windows(),
					miniclue.gen_clues.z(),
					{ mode = "n", keys = "<Leader>g", desc = "GIT" },
					{ mode = "n", keys = "<Leader>gd", desc = "Git diffview" },
					{ mode = "n", keys = "<Leader>s", desc = "Telescope" },
					{ mode = "n", keys = "<Leader>t", desc = "Toggles" },
				},
				window = {
					delay = 0,
				},
			})

			-- doesnt do c comments correcttly without ftplugin
			require("mini.comment").setup({
				options = {
					ignore_blank_line = true,
				},
			})

			-- similar to substitute. griw to replace word with buffer
			-- gxx gxx to exhange two lines, collides with open website gx
			-- g= to evaluate text
			-- gm to duplicate
			-- gs to sort (collides with switch header/source)
			require("mini.operators").setup({ sort = { prefix = "" }, exchange = { prefix = "" } })

			-- AUTOPAIRING. needs xzbdmw/clasp.nvim to replace ultimate-autopair functionality
			-- it may or may not work with pythons multiline comments
			require("mini.pairs").setup()
		end,
	},

	{
		"xzbdmw/clasp.nvim", -- it works well I like it
		config = function()
			require("clasp").setup({
				pairs = { ["{"] = "}", ['"'] = '"', ["'"] = "'", ["("] = ")", ["["] = "]", ["<"] = ">" },
				keep_insert_mode = true,
				remove_pattern = nil,
			})
			vim.keymap.set({ "n", "i" }, "<M-e>", function()
				require("clasp").wrap("next")
			end)
			vim.keymap.set({ "n", "i" }, "<M-E>", function()
				require("clasp").wrap("prev")
			end)
		end,
	},
}
