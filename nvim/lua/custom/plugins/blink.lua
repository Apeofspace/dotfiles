local M = {
	{
		-- https://github.com/Saghen/blink.cmp
		"saghen/blink.cmp",
		lazy = false, -- lazy loading handled internally
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "*",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			keymap = {
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide", "fallback" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = {
					-- function(cmp)
					-- 	if cmp.snippet_active() then
					-- 		return cmp.accept()
					-- 	else
					-- 		return cmp.select_and_accept()
					-- 	end
					-- end,
					"snippet_forward", -- next snippet element
					"fallback", -- normal tab basically
				},
				["<S-Tab>"] = { "snippet_backward", "fallback" },
				["<C-y>"] = { "accept", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-b>"] = { "scroll_documentation_up", "fallback" },
				["<C-f>"] = { "scroll_documentation_down", "fallback" },
				["<C-h>"] = { "snippet_forward", "fallback" },
				["<C-l>"] = { "snippet_backward", "fallback" },
			},
			appearance = {
				use_nvim_cmp_as_default = false, -- temp for beta
				nerd_font_variant = "mono",
			},
			sources = {
				default = { "lsp", "path", "buffer", "snippets" },
			},
			signature = { enabled = true }, -- experimental
		},
		opts_extend = { "sources.default" },
	},
}

return M
