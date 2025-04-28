local schemes = {
	{ "catppuccin/nvim", lazy = true, priority = 1000 },
	{ "rose-pine/neovim", lazy = true, priority = 1000 },
	{ "AlexvZyl/nordic.nvim", lazy = true, priority = 1000 },
	{ "romanaverin/charleston.nvim", lazy = true, priority = 1000 },
	{ "alexxGmZ/e-ink.nvim", lazy = true, priority = 1000 },
	{ "folke/tokyonight.nvim", lazy = true, priority = 1000 },
	{ "nyngwang/memoonry.nvim", lazy = true, priority = 1000 },
	{
		"ficcdaf/ashen.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			local ashen = require("ashen")
			-- local palette = require("ashen.colors")
			ashen.setup({
				colors = {
					-- color stolen from sonokai shusia
					-- for no good reason it becomes transparent if temrinal bg is same as
					-- theme bg regardless of transparency option
					-- background = "#1A181A",
					background = "#211F22",
					-- background = "#2D2A2E",
				},
				transparent = false,
				style_presets = {
					-- bold_functions = true,
					italic_comments = true,
				},
				hl = {
					merge_override = {
						["@function"] = { { bold = true } },
						["@function.call"] = { { bold = false, italic = false } },
						["@function.method.call"] = { { bold = false, italic = false } },
						["@function.builtin"] = { { bold = false, italic = false } },
						-- 		["@attribute"] = { { bold = true, italic = false } },
						-- 		["@keyword"] = { { bold = true, italic = false } },
								-- ["@keyword.function"] = {nil, nil, { bold = true, italic = false } },
						-- 		["@keyword.return"] = { { bold = true, italic = false } },
						-- 		["@keyword.exception"] = { { bold = true, italic = false } },
						-- 		["@keyword.repeat"] = { { bold = true, italic = false } },
						-- 		["@keyword.operator"] = { { bold = true, italic = false } },
						-- 		["@keyword.conditional"] = { { bold = true, italic = false } },
						-- 		["@keyword.modifier"] = { { bold = true, italic = false } },
						-- 		["@keyword.coroutine"] = { { bold = true, italic = false } },
						-- 		["@keyword.type"] = { { bold = true, italic = false } },
					},
				},
			})
			ashen.load({})
		end,
	},
	{
		"ellisonleao/gruvbox.nvim",
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
		"eldritch-theme/eldritch.nvim",
		lazy = true,
		priority = 1000,
		config = function()
			require("eldritch").setup({
				transparent = false,
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
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
		"olimorris/onedarkpro.nvim",
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
