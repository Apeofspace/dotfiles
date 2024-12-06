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
		-- enabled = false,
		lazy = false, -- lazy loading handled internally
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "v0.*",
		opts = {
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<Tab>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward", -- next snippet element
					"fallback", -- normal tab basically
				},
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-h>"] = { "snippet_forward", "fallback" },
				["<C-l>"] = { "snippet_backward", "fallback" },
			},
			completion = {
				menu = {
					draw = { columns = { { "kind_icon" }, { "label", "label_description", "kind", gap = 1 } } },
				},
				documentation = { auto_show = true },
				-- didnt look too good when tried
				ghost_text = { enabled = false },
				-- experimental auto-brackets support
				{ accept = { auto_brackets = { enabled = true } } },
			},
			-- Experimental signature help support
			signature = { enabled = true },
			sources = {
				completion = {
					-- list of enabled providers
					enabled_providers = { "lsp", "path", "snippets", "buffer" },
				},
				providers = {
					-- boost/penalize the score of the items (among other things)
					lsp = { score_offset = 1 },
					path = { score_offset = 3 },
					snippets = { score_offset = -3 },
					buffer = { score_offset = -2 },
				},
			},
		},
	},
}
