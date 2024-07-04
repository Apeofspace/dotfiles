return {
	{ -- LSP Configuration & Plugins
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for neovim
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			-- Useful status updates for LSP.
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			--  This function gets run when an LSP attaches to a particular buffer.
			--    That is to say, every time a new file is opened that is associated with
			--    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
			--    function will be executed to configure the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- Function that lets us more easily define mappings  for LSP
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>sd", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					map(
						"<leader>sw",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor
					--  Most Language Servers support renaming across files, etc.
					map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

					-- Opens a popup that displays documentation about the word under your cursor
					map("K", vim.lsp.buf.hover, "Hover Documentation")

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					-- toggle inlay_hints
					map("<leader>gh", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						if vim.lsp.inlay_hint.is_enabled() == true then
							print("Inlay hints enabled")
						else
							print("Inlay hints disabled")
						end
					end, "Toggle Inlay [H]ints")

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

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			-- Enable the following language servers
			--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
			--
			--  Add any additional override configuration in the following tables. Available keys are:
			--  - cmd (table): Override the default command used to start the server
			--  - filetypes (table): Override the default list of associated filetypes for the server
			--  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
			--  - settings (table): Override the default settings passed when initializing the server.
			--        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
			local ensure_installed_servers = {
				clangd = {
					cmd = {
						"clangd",
						"--query-driver=/usr/bin/arm-none-eabi-gcc",
						"--clang-tidy",
						"--background-index",
						"--header-insertion=iwyu",
						"--completion-style=detailed",
						-- '--function-arg-placeholders',
						-- '-j4',
						"--fallback-style=llvm",
						-- '--enable-config',
						-- "-style='{ColumnLimit: 150, }'",
					},
					single_file_support = true,
				},
				-- marksman = {},
				markdown_oxide = {
					-- try to extend capabilities for moxide. Read: https://github.com/Feel-ix-343/markdown-oxide
					capabilities = {
						workspace = {
							didChangeWatchedFiles = {
								dynamicRegistration = true,
							},
						},
					},
				},
				cmake = {},
				-- READ MORE ON PYTHON TOOLS https://inventwithpython.com/blog/2022/11/19/python-linter-comparison-2022-pylint-vs-pyflakes-vs-flake8-vs-autopep8-vs-bandit-vs-prospector-vs-pylama-vs-pyroma-vs-black-vs-mypy-vs-radon-vs-mccabe/
				-- pylsp = {
				--   -- install dependencies to make it work??
				--   -- pip install python-lsp-server flake8
				--   -- not sure if i need this or if mason can handle it
				--   -- https://github.com/python-lsp/python-lsp-server
				--   settings = {
				--     pylsp = {
				--       plugins = {
				--         jedi_completion = {
				--           enabled = true,
				--           include_params = true,
				--         },
				--         ruff = {
				--           enabled = false, -- doesnt work anyway
				--           ignore = { 'E501', 'E231' },
				--           formatEnabled = true,
				--           linelength = 120,
				--           format = { 'ALL' },
				--         },
				--         pylint = {
				--           -- error/style linter
				--           -- use this or pyflakes + pycodestyle
				--           -- said to be much slower than flake8
				--           enabled = false,
				--           debounce = 200,
				--           args = {
				--             '--ignore=E501,E231',
				--             '-',
				--           },
				--         },
				--         flake8 = {
				--           -- includes mccabe, pycodestyle (pep8), pyflakes
				--           enabled = false,
				--         },
				--         mccabe = {
				--           -- complexity analyzer
				--           -- responsible for cyclomatic complexity warnings
				--           enabled = false,
				--         },
				--         -- i need those two below or pylint
				--         pyflakes = {
				--           -- error linter (no style errors)
				--           enabled = true,
				--         },
				--         pycodestyle = {
				--           -- style linter only
				--           enabled = true,
				--           ignore = { 'E501', 'E231' },
				--           maxLineLength = 120,
				--         },
				--         pylsp_mypy = {
				--           -- static types analyzer.
				--           -- Alternatives with similar functionality: pyright, pyre, pytype
				--           enabled = false,
				--           report_progress = true,
				--         },
				--       },
				--     },
				--   },
				-- },
				-- use ruff and jedi together or just pylsp honestly
				jedi_language_server = {},
				-- pyright = {},
				-- pylyzer = {},
				ruff = {
					ignore = { "E501", "E231" },
					formatEnabled = false,
					linelength = 120,
				},
				lua_ls = {
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
							},
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			-- Ensure the servers and tools above are installed
			require("mason").setup()
			-- You can add other tools here that you want Mason to install
			local ensure_installed = vim.tbl_keys(ensure_installed_servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
				-- 'ruff',
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
