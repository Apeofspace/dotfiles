return {
	{ -- Autocompletion
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		enabled = false,
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets.
					-- This step is not supported in many windows environments.
					-- Remove the below condition to re-enable on windows.
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
				dependencies = {
					-- `friendly-snippets` contains a variety of premade snippets.
					--    See the README about individual language/framework/plugin snippets:
					--    https://github.com/rafamadriz/friendly-snippets
					{
						"rafamadriz/friendly-snippets",
						config = function()
							require("luasnip.loaders.from_vscode").lazy_load()
						end,
					},
				},
			},
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			luasnip.config.setup({})

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },
				window = {
					documentation = {
						-- use all available space
						max_width = 0,
						max_height = 0,
					},
				},
				mapping = cmp.mapping.preset.insert({
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Scroll the documentation window [b]ack / [f]orward
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),

					-- Accept ([y]es) the completion.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<TAB>"] = cmp.mapping.confirm({ select = true }),

					-- Manually trigger a completion from nvim-cmp.
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-CR>"] = cmp.mapping.complete({}),

					-- moving in snipped expansion
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
				sources = {
					{ name = "supermaven", priority = 500 },
					{ name = "nvim_lsp", priority = 400 },
					{ name = "luasnip", priority = 1000 },
					{ name = "path", priority = 100 },
					{ name = "buffer", priority = 200 },
				},
			})
		end,
	},
	{
		-- WARN this plugin likely to have breaking changes
		-- https://github.com/Saghen/blink.cmp
		"saghen/blink.cmp",
		enabled = true,
		lazy = false, -- lazy loading handled internally
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v0.*",
		opts = {
			highlight = {
				use_nvim_cmp_as_default = true, -- temp
			},
			nerd_font_variant = "normal",
			-- experimental auto-brackets support
			accept = { auto_brackets = { enabled = true } },
			-- experimental signature help support
			-- trigger = { signature_help = { enabled = true } },
			keymap = {
				snippet_forward = "<C-l>",
				snippet_backward = "<C-h>",
			},
			windows = {
				documentation = { auto_show = true },
			},

			sources = {
				-- list of enabled providers
				completion = {
					enabled_providers = { "lsp", "path", "snippets", "buffer" },
				},

				providers = {
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",

						--- *All* of the providers have the following options available
						--- NOTE: All of these options may be functions to get dynamic behavior
						--- See the type definitions for more information
						enabled = true, -- whether or not to enable the provider
						transform_items = nil, -- function to transform the items before they're returned
						should_show_items = true, -- whether or not to show the items
						max_items = nil, -- maximum number of items to return
						min_keyword_length = 0, -- minimum number of characters to trigger the provider
						fallback_for = {}, -- if any of these providers return 0 items, it will fallback to this provider
						score_offset = 1, -- boost/penalize the score of the items
						override = nil, -- override the source's functions
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 3,
						opts = {
							trailing_slash = false,
							label_trailing_slash = true,
							get_cwd = function(context)
								return vim.fn.expand(("#%d:p:h"):format(context.bufnr))
							end,
							show_hidden_files_by_default = false,
						},
					},
					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						score_offset = -3,
						opts = {
							friendly_snippets = true,
							search_paths = { vim.fn.stdpath("config") .. "/snippets" },
							global_snippets = { "all" },
							extended_filetypes = {},
							ignored_filetypes = {},
						},

						--- Example usage for disabling the snippet provider after pressing trigger characters (i.e. ".")
						-- enabled = function(ctx) return ctx ~= nil and ctx.trigger.kind == vim.lsp.protocol.CompletionTriggerKind.TriggerCharacter end,
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
						score_offset = -2,
						fallback_for = { "lsp" },
					},
				},
			},

			-- sources = {
			-- providers = {
			-- 	{ "blink.cmp.sources.lsp", name = "LSP", score_offset = 1 },
			-- 	{
			-- 		"blink.cmp.sources.snippets",
			-- 		name = "Snippets",
			-- 	},
			-- 	{ "blink.cmp.sources.path", name = "Path", score_offset = 3, opts = { get_cwd = vim.uv.cwd } },
			-- 	{
			-- 		"blink.cmp.sources.buffer",
			-- 		name = "Buffer",
			-- 		keyword_length = 3,
			-- 		score_offset = -2,
			-- 		fallback_for = { "Path" }, -- PENDING https://github.com/Saghen/blink.cmp/issues/122
			-- 	},
			-- },
			-- },
		},
	},
}
