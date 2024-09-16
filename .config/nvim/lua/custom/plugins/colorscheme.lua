local schemes = {
	{
		"ferdinandrau/lavish.nvim",
		name = "lavish",
		priority = 1000,
		config = function()
			require("lavish").apply()
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
		-- variants = { "tokyonight-day", "tokyonight-moon", "tokyonight-night", "tokyonight-storm" },
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
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- vim.cmd.colorscheme 'eldritch'
			require("eldritch").setup({
				transparent = false,
			})
		end,
	},
	{
		"loctvl842/monokai-pro.nvim",
		name = "monokai-pro",
		-- variants = {
		-- 	"monokai-pro-classic",
		-- 	"monokai-pro-machine",
		-- 	"monokai-pro-default",
		-- 	"monokai-pro-spectrum",
		-- 	"monokai-pro-ristretto",
		-- 	"monokai-pro-machine",
		-- 	"monokai-pro-octagon",
		-- },
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("monokai-pro").setup({
				filter = "pro",
			})
			-- vim.cmd.colorscheme 'monokai-pro'
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- variants = {
		-- 	"catpuccin",
		-- 	"catpuccin-frappe",
		-- 	"catpuccin-mocchiato",
		-- 	"catpuccin-latte",
		-- 	"catpuccin-mocha",
		-- },
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
			-- vim.cmd.colorscheme 'catppuccin-macchiato'
		end,
	},
	{
		"savq/melange-nvim",
		name = "melange",
		lazy = true, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
			-- vim.cmd.colorscheme 'melange'
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
			-- vim.cmd.colorscheme 'hybrid'
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		lazy = true,
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				commentStyle = { italic = true },
				functionStyle = {},
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				transparent = true,
				theme = "wave", -- Load "wave" theme when 'background' option is not set
				background = { -- map the value of 'background' option to a theme
					dark = "wave", -- try "dragon" !
					light = "lotus",
				},
			})
		end,
	},
	{ "rose-pine/neovim", name = "rose-pine", lazy = true, priority = 1000 },
	{
		"AlexvZyl/nordic.nvim",
		name = "nordic",
		lazy = true,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{
		"neanias/everforest-nvim",
		name = "everforest",
		version = false,
		lazy = true,
		priority = 1000,
		config = function()
			require("everforest").setup({
				transparent = true,
				background = "hard",
				transparent_background_level = 2,
			})
		end,
	},
	{
		"2giosangmitom/nightfall.nvim",
		name = "nightfall",
		lazy = true,
		priority = 1000,
		opts = {
			transparent = false,
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

				transparent = true,
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
		name = "onedark",
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
					-- ["@diff.minus"] = { fg = palette.dark_red },
					-- ["@diff.plus"] = { fg = palette.bright_green },
					-- ["@diff.delta"] = { fg = palette.bright_aqua },
					-- ["@module"] = { italic = true },
					-- ["@module.buitlin"] = { italic = true, fg = palette.bright_orange },
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
		"sainnhe/edge",
		name = "edge",
		lazy = true,
		priority = 1000,
		config = function()
			vim.g.edge_style = "neon"
			vim.g.edge_enable_italic = true
			vim.g.edge_current_word = "bold"
		end,
	},
}

------------------------------------------------------------------

-- Path to the file where the colorscheme will be saved
local colorscheme_file = vim.fn.stdpath("config") .. "/lua/custom/colorscheme.txt"

local function read_colorscheme()
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
	local active_scheme = read_colorscheme()
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

vim.keymap.set("n", "<leader>cs", function() --> Show all custom colors in telescope...
	for _, color in ipairs(schemes) do --> Load all colors in spec....
		vim.cmd("Lazy load " .. color.name) --> vim colorschemes cannot be required...
	end

	vim.schedule(function() --> Needs to be scheduled:
    -- stylua: ignore
    local builtins = { "zellner", "torte", "slate", "shine", "ron", "quiet", "peachpuff",
    "pablo", "murphy", "lunaperche", "koehler", "industry", "evening", "elflord",
    "desert", "delek", "default", "darkblue", "blue", "zaibatsu", "vim", "retrobox",
			'morning', 'randomhue', 'wildcharm', 'habamax' , 'sorbet', 'minischeme', 'minicyan'}

		local completion = vim.fn.getcompletion
		---@diagnostic disable-next-line: duplicate-set-field
		vim.fn.getcompletion = function() --> override
			return vim.tbl_filter(function(color)
				return not vim.tbl_contains(builtins, color) --
			end, completion("", "color"))
		end

		vim.cmd("Telescope colorscheme enable_preview=true")
		vim.fn.getcompletion = completion --> restore
	end)
end, { desc = "Telescope COLORSCHEMES", silent = true })

-- function ReloadColorScheme()
-- 	local current_scheme = vim.g.colors_name
-- 	vim.cmd("colorscheme" .. current_scheme)
-- end

return schemes
