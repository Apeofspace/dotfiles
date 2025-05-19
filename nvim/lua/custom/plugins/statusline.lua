local get_linecount = function()
	return vim.fn.line("$") or ""
end

local function noice_stuff()
	local ok, noice = pcall(require, "noice")
	if not ok then
		return nil
	end

	return {
		noice.api.statusline.mode.get,
		cond = noice.api.statusline.mode.has,
		color = { fg = "#ff9e64" },
	}
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
	lualine_c = { "diagnostics", noice_stuff() }, -- yeah deal with it
	-- lualine_c = { "diagnostics", get_arrow },
	lualine_x = { "g:obsidian", "encoding", "filesize", "filetype" },
	lualine_y = { "progress", get_linecount },
	lualine_z = { "location" },
}

local winbar_config = {
	lualine_a = {
		function()
			local cwdpath = vim.uv.cwd()
			local parts = vim.split(cwdpath, "/", { plain = true })
			if parts then
				return parts[#parts]
			else
				return ""
			end
		end,
	},
	lualine_b = {
		function()
			local relpath = vim.fn.fnamemodify(vim.fn.expand("%"), ":~:.")
			if relpath then
				local parts = vim.split(relpath, "/", { plain = true })
				local result = table.concat(parts, "  ", 1, #parts - 1)
				return result
			else
				return ""
			end
		end,
	},
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

local M = {
	{
		-- https://neoland.dev/plugin/8327
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			options = { globalstatus = true }, -- single bar
			sections = section_config,
			-- inactive_sections = section_config,
			-- tabline = tabline_config,
			-- winbar = winbar_config,
			-- inactive_winbar = winbar_config,
		},
	},
	{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		enabled = true,
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		-- config = function ()
		--   require("nvim-web-devicons").setup()
		--   require("barbecue").setup()
		-- end
		opts = {},
	},
}

return M
