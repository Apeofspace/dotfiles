M = {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
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
			format_on_save = function(bufnr)
				-- disable format on save for some filetypes entirely
				-- enable format on save but disable lsp fallback for some filetypes
				local disable_filetypes = { c = true, cpp = true } -- NOTE DISABLED FILETYPES HERE <<<---
				local no_fallback_filetupes = { c = false, cpp = false }
				local lsp_format_opt
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return false
				else
					if no_fallback_filetupes[vim.bo[bufnr].filetype] then
						lsp_format_opt = "never"
					else
						lsp_format_opt = "fallback"
					end
					return {
						timeout_ms = 1000,
						lsp_format = lsp_format_opt,
					}
				end
			end,

			formatters_by_ft = {
				-- Use the "*" filetype to run formatters on all filetypes.
				-- ["*"] = { "codespell" },
				lua = { "stylua" },
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_fix", "ruff_format", "ruff_organize_imports" }
					else
						return { "isort", "black", stop_after_first = false }
					end
				end,
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				-- WARN: astyle needs to be installed manually
				c = { "astyle" },
				cpp = { "astyle" },
			},
			formatters = {
				ruff_format = {
					command = "ruff check",
					prepend_args = { "--line-length=125", '--indent-style="space"' },
				},
				black = {
					prepend_args = { "--line-length=125" },
					-- check https://pypi.org/project/black/
				},
				astyle = {
					-- check https://astyle.sourceforge.net/astyle.html#_Brace_Style_Options
					prepend_args = {
						"--style=google",
						"--indent=spaces=2 ",
						"--max-code-length=120",
						"--pad-oper",
						"--pad-comma",
						"--pad-header",
						"--squeeze-ws",
						"--squeeze-lines=2", -- anything more than 2 empty lines removed
						"--break-one-line-headers",
					},
				},
			},
		},
	},

	-- automatically download conform formatters with mason
	{
		"zapling/mason-conform.nvim",
		enabled = false,
		-- WARN: this is disabled due to mason conform not supporting functions
		-- in formatters table in conform
		-- check more here
		-- https://github.com/zapling/mason-conform.nvim/issues/8
		dependencies = {
			"williamboman/mason.nvim",
			"stevearc/conform.nvim",
		},
		opts = {
			ignore_install = { "prettier", "prettierd" }, -- List of formatters to ignore during install
		},
	},
}

return M
