local get_linecount = function()
	return vim.fn.line("$") or ""
end

local statusline = require("arrow.statusline")

local function get_arrow()
	if statusline.is_on_arrow_file() then
		return statusline.text_for_statusline_with_icons()
	end
	return ""
end

local section_config = {
	-- +-------------------------------------------------+
	-- | A | B | C                             X | Y | Z |
	-- +-------------------------------------------------+
	lualine_a = { "mode" },
	lualine_b = { "branch", "diff", "diagnostics" },
	lualine_c = { "filename", get_arrow },
	lualine_x = { "encoding", "filesize", "filetype" },
	lualine_y = { "progress", get_linecount },
	lualine_z = { "location" },
}

return {
	-- https://neoland.dev/plugin/8327
	"nvim-lualine/lualine.nvim",
	lazy = true,
	event = "User ColorschemeLoaded",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sections = section_config,
		inactive_sections = section_config,
	},
}
