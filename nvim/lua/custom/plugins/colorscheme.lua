local schemes = {
	{ "catppuccin/nvim", name = "catppuccin", lazy = true, priority = 1000 },
	{ "loctvl842/monokai-pro.nvim", name = "monokai-pro", lazy = true, priority = 1000 },
	{ "rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000 },
	{ "AlexvZyl/nordic.nvim", name = "nordic", lazy = true, priority = 1000 },
	{ "savq/melange-nvim", name = "melange", lazy = true, priority = 1000 },
	{ "philosofonusus/morta.nvim", name = "morta", lazy = true, priority = 1000 },
	{
		"drewxs/ash.nvim",
		lazy = true,
		priority = 1000,
		name = "ash",
	},
	{
		"Skardyy/makurai-nvim",
		lazy = true,
		priority = 1000,
		name = "makurai",
	},
	{
		"ficcdaf/ashen.nvim",
		lazy = true,
		name = "ashen",
		priority = 1000,
		opts = {
			transparent = false, -- its transparent anyway
			style_presets = {
				bold_functions = false,
				italic_comments = true,
			},
			-- hl = {
			-- 	merge_override = {
			-- 		-- this doesnt merge, it completely overrides
			-- 		["@type"] = { nil, nil, { bold = true } },
			-- 		["@type.builtin"] = { nil, nil, { bold = true } },
			-- 		["@keyword.modifier"] = { nil, nil, { bold = true } },
			-- 		["@type.definition"] = { nil, nil, { bold = true } },
			-- 	},
			-- },
		},
	},
	{
		"ellisonleao/gruvbox.nvim",
		name = "gruvbox",
		lazy = true,
		priority = 1000,
		config = function()
			local gruvbox = require("gruvbox")
			local palette = gruvbox.palette
			gruvbox.setup({
				undercurl = true,
				underline = true,
				bold = true,
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					operators = false,
					folds = true,
				},
				strikethrough = true,
				dim_inactive = false,
				transparent_mode = false,
				overrides = {
					["@attribute"] = { italic = true },
					["@keyword"] = { italic = true, bold = false, fg = palette.bright_red },
					["@keyword.function"] = { italic = true, bold = true, fg = palette.bright_red },
					["@keyword.return"] = { italic = true, bold = true, fg = palette.bright_red },
					["@keyword.exception"] = { italic = true, bold = true, fg = palette.bright_red },
					["@keyword.repeat"] = { italic = true, bold = false, fg = palette.bright_red },
					["@keyword.operator"] = { italic = true, bold = false, fg = palette.bright_red },
					["@keyword.conditional"] = { italic = true, bold = false, fg = palette.bright_red },
					["@keyword.modifier"] = { italic = true, fg = palette.bright_red },
					["@keyword.coroutine"] = { italic = true, fg = palette.bright_red },
					["@keyword.type"] = { italic = true, bold = true, fg = palette.bright_red },
				},
			})
		end,
	},
	{
		"sainnhe/gruvbox-material",
		name = "gruvbox-material",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.gruvbox_material_enable_italic = 1
			vim.g.gruvbox_material_background = "medium"
			vim.g.gruvbox_material_foreground = "material"
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_enable_bold = 1
			vim.g.gruvbox_material_better_performance = 1
		end,
	},
	{
		"sainnhe/sonokai",
		name = "sonokai",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.sonokai_style = "shusia"
			vim.g.sonokai_enable_italic = true
			vim.g.sonokai_transparent_background = false
			vim.g.sonokai_current_word = "bold"
			vim.g.sonokai_better_performance = 1
		end,
	},
	{
		"folke/tokyonight.nvim",
		name = "tokyonight",
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			styles = {
				sidebars = "transparent",
				floats = "transparent",
			},
		},
	},
	{
		"eldritch-theme/eldritch.nvim",
		name = "eldritch",
		lazy = true,
		priority = 1000,
		config = function()
			require("eldritch").setup({
				transparent = false,
			})
		end,
	},
	{
		"HoNamDuong/hybrid.nvim",
		name = "hybrid",
		lazy = true,
		priority = 1000,
		config = function()
			require("hybrid").setup({
				italic = {
					strings = true,
					emphasis = true,
					comments = true,
					folds = true,
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = true,
		priority = 1000,
		opts = {
			commentStyle = { italic = true },
			functionStyle = {},
			keywordStyle = { italic = true },
			statementStyle = { bold = true },
			typeStyle = {},
			-- transparent = true,
			theme = "wave", -- Load "wave" theme when 'background' option is not set
			background = { -- map the value of 'background' option to a theme
				dark = "dragon", -- try "dragon" !
				light = "lotus",
			},
		},
	},
	{
		"neanias/everforest-nvim",
		name = "everforest",
		version = false,
		lazy = true,
		priority = 1000,
		config = function()
			require("everforest").setup({
				background = "hard",
				italics = true,
				-- transparent_background_level = 2,
			})
		end,
	},
	{
		"2giosangmitom/nightfall.nvim",
		name = "nightfall",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = true,
			dim_inactive = true,
			integrations = {
				telescope = {
					enabled = true,
					style = "bordered",
				},
			},
		},
	},
	{
		"EdenEast/nightfox.nvim",
		name = "nightfox",
		lazy = true,
		priority = 1000,
		opts = {
			options = {
				transparent = false,
				-- transparent = true,
				dim_inactive = false,
				integrations = {
					telescope = {
						enabled = true,
						style = "bordered",
					},
				},
				styles = { -- Style to be applied to different syntax groups
					types = "italic",
					methods = "NONE",
					numbers = "NONE",
					strings = "italic",
					comments = "italic",
					keywords = "bold,italic",
					constants = "NONE",
					functions = "italic",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "italic",
					virtual_text = "italic",
				},
			},
		},
	},
	{
		"olimorris/onedarkpro.nvim",
		name = "onedarkpro",
		lazy = true,
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				options = {
					-- transparency = true,
					lualine_transparency = true,
				},
				styles = {
					types = "italic",
					methods = "NONE",
					numbers = "NONE",
					strings = "italic",
					comments = "italic",
					keywords = "bold,italic",
					constants = "NONE",
					functions = "italic",
					operators = "NONE",
					variables = "NONE",
					parameters = "NONE",
					conditionals = "italic",
					virtual_text = "italic",
				},
			})
		end,
	},
	{
		"Mofiqul/dracula.nvim",
		name = "dracula",
		lazy = true,
		priority = 1000,
		opts = {
			theme = "dracula-soft",
			transparent_bg = false,
			italic_comment = true,
		},
	},
	{
		"ramojus/mellifluous.nvim",
		name = "mellifluous",
		lazy = true,
		priority = 1000,
		opts = {
			styles = { -- see :h attr-list for options. set {} for NONE, { option = true } for option
				main_keywords = { bold = true },
			},
		},
	},
}

------------------------------------------------------------------

-- Path to the file where the colorscheme will be saved
local colorscheme_file = vim.fn.stdpath("config") .. "/lua/custom/colorscheme.txt"

function schemes.read_colorscheme()
	local f = io.open(colorscheme_file, "r")
	if f then
		local colorscheme = f:read("*l")
		f:close()
		return colorscheme
	end
	return nil
end

local function write_colorscheme(colorscheme)
	local f = io.open(colorscheme_file, "w")
	if f then
		f:write(colorscheme)
		f:close()
	end
end

function schemes.SetColorschemeFromFile()
	local active_scheme = schemes.read_colorscheme()
	if active_scheme then
		vim.cmd("colorscheme " .. active_scheme)
	end
end

-- write on loading scheme
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		local current_scheme = vim.g.colors_name
		write_colorscheme(current_scheme)
	end,
})

-- TELESCOPE PICKER (requires each theme to have a name)
-- vim.keymap.set("n", "<leader>cs", function() --> Show all custom colors in telescope...
-- 	for _, color in ipairs(schemes) do --> Load all colors in spec....
-- 		vim.cmd("Lazy load " .. color.name) --> vim colorschemes cannot be required...
-- 	end
-- 	vim.schedule(function() --> Needs to be scheduled:
--     -- stylua: ignore
--     local builtins = { "zellner", "torte", "slate", "shine", "ron", "quiet", "peachpuff",
--     "pablo", "murphy", "lunaperche", "koehler", "industry", "evening", "elflord",
--     "desert", "delek", "default", "darkblue", "blue", "zaibatsu", "vim", "retrobox",
-- 			'morning', 'randomhue', 'wildcharm', 'habamax' , 'sorbet', 'minischeme', 'minicyan'}
-- 		local completion = vim.fn.getcompletion
-- 		---@diagnostic disable-next-line: duplicate-set-field
-- 		vim.fn.getcompletion = function(pat, type) --> override
-- 			return vim.tbl_filter(function(color)
-- 				return not vim.tbl_contains(builtins, color) --
-- 			end, completion("", "color"))
-- 		end
-- 		vim.cmd("Telescope colorscheme enable_preview=true")
-- 		vim.fn.getcompletion = completion --> restore
-- 	end)
-- end, { desc = "Telescope COLORSCHEMES", silent = true })

return schemes
