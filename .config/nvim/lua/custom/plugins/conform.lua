return {
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "[F]ormat buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = function(bufnr)
				local disable_filetypes = { c = true, cpp = true }
				return {
					timeout_ms = 1000,
					lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
				}
			end,
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
				-- ruff supposed to be faster than black but same otherwise
				-- python = { 'ruff_fix', 'ruff_format', 'ruff_organize_imports' },
				javascript = { { "prettierd", "prettier" } },
				typescript = { { "prettierd", "prettier" } },
				json = { { "prettierd", "prettier" } },
				jsonc = { { "prettierd", "prettier" } },
				-- You can use a sub-list to tell conform to run *until* a formatter is found.
				c = { { "astyle" } },
				-- WARN: astyle needs to be installed manually
				cpp = { { "astyle" } },
			},
			formatters = {
				-- ruff_format = {
				--   prepend_args = { '--line-length=125' },
				-- },
				black = {
					prepend_args = { "--line-length=125" },
					-- check https://pypi.org/project/black/
				},
				astyle = {
					prepend_args = { "--style=google", "--indent=spaces=2 ", "--max-code-length=120" },
					-- check https://astyle.sourceforge.net/astyle.html#_Brace_Style_Options
				},
			},
		},
	},
	-- automatically download conform formatters with mason
	{ "zapling/mason-conform.nvim", opts = {} },
}
