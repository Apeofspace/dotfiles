return {
	{ -- Collection of various small independent plugins/modules
		"echasnovski/mini.nvim",
		version = false,
		config = function()
			-- Better Around/Inside textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [']quote
			--  - ci'  - [C]hange [I]nside [']quote
			require("mini.ai").setup({ n_lines = 500 })

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require("mini.surround").setup()
			-- can use ultimate-autopair fastwrap instead

			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			-- local statusline = require("mini.statusline")
			-- statusline.setup()

			-- -- You can configure sections in the statusline by overriding their
			-- -- default behavior. For example, here we set the section for
			-- -- cursor location to LINE:COLUMN
			-- ---@diagnostic disable-next-line: duplicate-set-field
			-- statusline.section_location = function()
			-- 	return "%2l:%-2v"
			-- end

			local function gethomedir()
				if vim.loop.os_uname().sysname == "Windows" or vim.loop.os_uname().sysname == "Windows_NT" then
					return os.getenv("HOMEPATH")
				elseif vim.loop.os_uname().sysname == "Linux" then
					return os.getenv("HOME")
				end
			end
			-- Works using :mksession (meaning sessionoptions is fully respected).
			-- Implements both global (from configured directory) and local (from current directory) sessions.
			-- Autoread default session (local if detected, latest otherwise) if Neovim was called without intention to show something else.
			-- Autowrite current session before quitting Neovim.
			-- TODO: checkout global sessions
			require("mini.sessions").setup({
				autoread = true,
				autowrite = true,
				-- directory = os.getenv("HOME") .. "/.nvim/minisesh",
				directory = gethomedir() .. "/.nvim/minisesh",
			})

			-- ultimate.autopair works better
			-- require('mini.pairs').setup()

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
			vim.keymap.set("n", "<leader>go", function()
				vim.cmd("lua MiniDiff.toggle_overlay()")
			end)

			require("mini.move").setup()
			-- ... and there is more!
			--  Check out: https://github.com/echasnovski/mini.nvim
		end,
	},
}
