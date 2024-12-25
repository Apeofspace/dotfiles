local M = {
	{
		-- WARN this plugin likely to have breaking changes
		-- https://github.com/Saghen/blink.cmp
		"saghen/blink.cmp",
		-- enabled = false,
		lazy = false, -- lazy loading handled internally
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
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
			appearance = {
				use_nvim_cmp_as_default = true, -- temp for beta
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			signature = { enabled = true }, -- experimental
			completion = {
				ghost_text = { enabled = true },
			},
		},
		opts_extend = { "sources.default" },
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
