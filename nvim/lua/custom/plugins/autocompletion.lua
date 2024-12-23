local M = {
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
	{
		"altermo/ultimate-autopair.nvim",
		-- :help ultimate-autopair
		-- Alt+e for fastwrap
		opts = {
			space = {
				enable = false,
				check_box_ft = { "markdown", "text" },
			},
		},
	},
}

return M
