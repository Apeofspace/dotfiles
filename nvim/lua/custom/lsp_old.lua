local M = {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("gs", ":ClangdSwitchSourceHeader<CR>", "Switch Source/Header")
					map("<leader>th", function() -- toggle inlay_hints
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						if vim.lsp.inlay_hint.is_enabled() == true then
							vim.notify("Inlay hints enabled")
						else
							vim.notify("Inlay hints disabled")
						end
					end, "[T]oggle Inlay [H]ints")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			local capabilities = vim.lsp.protocol.make_client_capabilities()
			-- passing config.capabilities to blink.cmp merges with the capabilities in yourprintdisablei
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			-- whatever in this table gets passed directly to
			-- require('lspconfig').server.setup()
			-- can OVERWRITE capabilities by adding capabilities field to the table
			local ensure_installed_servers = {
				clangd = {
					-- can use built in ckangd formatter. check below
					-- https://clang.llvm.org/docs/ClangFormat.html
					-- https://clang.llvm.org/docs/ClangFormatStyleOptions.html
					cmd = {
						"clangd",
						"--query-driver=/usr/bin/arm-none-eabi-gcc",
						-- "--clang-tidy",
						-- "--background-index",
						-- "--header-insertion=iwyu",
						-- "--completion-style=detailed",
						-- -- '--style="{BasedOnStyle: Google, IndentWidth: 2, ColumnLimit: 120}"',
						-- "--fallback-style=Google",
					},
					single_file_support = true, -- its true by default
				},
				cmake = {},
				marksman = {},
				basedpyright = {
					settings = {
						basedpyright = {
							disableOrganizeImports = true, -- ruff
							analysis = {
								typeCheckingMode = "basic",
								diagnosticSeverityOverrides = {
									reportOptionalMemberAccess = false, -- "warning"
								},
							},
						},
					},
				},
				ruff = {
					init_options = {
						settings = {
							lint = { enable = false }, -- DISABLE LINTING (use pyright)
							ignore = { "E501", "E231" },
							formatEnabled = true, -- use conform if false
							-- formatEnabled = false, -- use conform if false
							lineLength = 125,
						},
					},
					server_capabilities = {
						hoverProvider = false, -- pyright
						signatureHelpProvider = false, -- pyright (not sure if this even works)
					},
				},
				lua_ls = {
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							diagnostics = { disable = { "missing-fields" }, globals = { "vim" } },
						},
					},
				},
				codespell = {},
			}

			-- Ensure the servers and tools above are installed
			require("mason").setup()
			-- You can add other tools here that you want Mason to install
			local ensure_installed = vim.tbl_keys(ensure_installed_servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
				-- "codespell",
				-- "isort",
				-- "black",
				-- "prettierd",
				-- "astyle", -- its not on masons list
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = ensure_installed_servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}

-- return M
return {}
