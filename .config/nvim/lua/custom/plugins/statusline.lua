local get_linecount = function()
	return vim.fn.line("$") or ""
end

-- local statusline = require("arrow.statusline")

-- local function get_arrow()
-- 	if statusline.is_on_arrow_file() then
-- 		return statusline.text_for_statusline_with_icons()
-- 	end
-- 	return ""
-- end

-- this is older config
-- local section_config = {
-- 	-- +-------------------------------------------------+
-- 	-- | A | B | C                             X | Y | Z |
-- 	-- +-------------------------------------------------+
-- 	lualine_a = { "mode" },
-- 	lualine_b = { "branch", "diff", "diagnostics" },
-- 	lualine_c = { "filename", get_arrow },
-- 	lualine_x = { "encoding", "filesize", "filetype" },
-- 	lualine_y = { "progress", get_linecount },
-- 	lualine_z = { "location" },
-- }

local section_config = {
	-- +-------------------------------------------------+
	-- | A | B | C                             X | Y | Z |
	-- +-------------------------------------------------+
	lualine_a = { "mode" },
	lualine_b = { "branch", "filename" },
	lualine_c = { "diagnostics" },
	-- lualine_c = { "diagnostics", get_arrow },
	lualine_x = { "encoding", "filesize", "filetype" },
	lualine_y = { "progress", get_linecount },
	lualine_z = { "location" },
}

local winbar_config = {
	lualine_a = {},
	lualine_b = {},
	lualine_c = { "filename" },
	lualine_x = {},
	lualine_y = {},
	lualine_z = {},
}
local tabline_config = {
	lualine_a = { {
		"tabs",
		mode = 2,
		cond = function()
			return #vim.fn.gettabinfo() > 1
		end,
	} },
}

return {
	-- https://neoland.dev/plugin/8327
	"nvim-lualine/lualine.nvim",
	-- lazy = true,
	-- event = "User ColorschemeLoaded",
	-- event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		sections = section_config,
		inactive_sections = section_config,
		-- tabline = tabline_config,
		-- winbar = winbar_config,
		-- inactive_winbar = winbar_config,
	},
}
