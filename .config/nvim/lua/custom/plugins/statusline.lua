local get_linecount = function()
	return vim.fn.line("$") or ""
end

return {
	-- https://neoland.dev/plugin/8327
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sections = {
			-- +-------------------------------------------------+
			-- | A | B | C                             X | Y | Z |
			-- +-------------------------------------------------+
			lualine_x = { "encoding", "filesize", "filetype" },
			lualine_y = { "progress", get_linecount },
		},
		inactive_sections = {},
	},
}
