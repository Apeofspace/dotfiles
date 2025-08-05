-- https://clang.llvm.org/docs/ClangFormatStyleOptions.html
local M = {
	"stevearc/conform.nvim",
	cmd = { "ConformInfo" },
  enabled = false,
	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({ async = true })
			end,
			mode = "",
			desc = "[F]ormat buffer",
		},
	},
	opts = {
		notify_on_error = false,
		default_format_options = {
			timeout_ms = 500,
			lsp_format = "fallback",
		},
		format_on_save = false,
		formatters_by_ft = {
			-- Use the "*" filetype to run formatters on all filetypes.
			lua = { "stylua" },
			python = { "ruff_format", "ruff_organize_imports", stop_after_first = false },
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
			markdown = { "prettierd", "prettier", stop_after_first = true },
			html = { "prettierd", "prettier", stop_after_first = true },
			css = { "prettierd", "prettier", stop_after_first = true },
			yaml = { "prettierd" },
			json = { "prettierd", "prettier", stop_after_first = true },
			jsonc = { "prettierd", "prettier", stop_after_first = true },
			c = { "clang-format", stop_after_first = true, lsp_format = "never" },
			-- c = { "astyle", "clang-format", stop_after_first = true },
			cpp = { "astyle", "clang-format", stop_after_first = true },
		},
		formatters = {
			ruff_format = {
				prepend_args = { "format", "--line-length=115" },
			},
			black = {
				prepend_args = { "--line-length=115" },
				-- check https://pypi.org/project/black/
			},
			astyle = {
				-- check https://astyle.sourceforge.net/astyle.html#_Brace_Style_Options
				prepend_args = {
					"--style=google",
					"--indent=spaces=2 ",
					"--max-code-length=125",
					"--pad-oper",
					"--pad-comma",
					"--pad-header",
					"--squeeze-ws",
					"--squeeze-lines=2", -- anything more than 2 empty lines removed
					"--break-one-line-headers",
					"--pad-paren-in", -- pad inside parenteses
				},
			},
			clang_format = {
				prepend_args = "--style=file",
				-- prepend_args = clang_styles,
			},
		},
	},
}
return M
