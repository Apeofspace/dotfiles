local colorschemes = {
	"sonokai",
	"monokai-pro",
	"kanagawa",
	"rose-pine",
	"nordic",
	"tokyonight-night",
	"eldritch",
	"catppuccin",
	"melange",
	"hybrid",
	"everforest",
}

-- Path to the file where the colorscheme will be saved
local colorscheme_file = vim.fn.stdpath("config") .. "/lua/custom/colorscheme.txt"
local colorschemeindex = 1

function read_colorscheme()
	local f = io.open(colorscheme_file, "r")
	if f then
		local colorscheme = f:read("*n")
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

local function setColorscheme(index)
	vim.cmd("colorscheme " .. colorschemes[index])
	vim.notify("Colorscheme: " .. colorschemes[index])
	write_colorscheme(index)
end

local function NextColorScheme()
	colorschemeindex = colorschemeindex + 1
	if colorschemeindex <= 0 or colorschemeindex > #colorschemes then
		colorschemeindex = 1
	end
	setColorscheme(colorschemeindex)
end

local function PrevColorScheme()
	colorschemeindex = colorschemeindex - 1
	if colorschemeindex <= 0 or colorschemeindex > #colorschemes then
		colorschemeindex = #colorschemes
	end
	setColorscheme(colorschemeindex)
end

vim.keymap.set("n", "<leader>cn", NextColorScheme, { desc = "[N]ext [C]olorscheme" })
vim.keymap.set("n", "<leader>cp", PrevColorScheme, { desc = "[P]rev [C]olorscheme" })

-- Defer loading the colorscheme until VimEnter
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		local saved_index = read_colorscheme()
		if saved_index and saved_index >= 1 and saved_index <= #colorschemes then
			colorschemeindex = saved_index
		else
			colorschemeindex = 1
		end
		setColorscheme(colorschemeindex)
		-- Autocmd for breakindent plugin, otherwise it breaks exoticly
		vim.cmd("doautocmd User ColorschemeLoaded")
	end,
})

return {
	{
		"sainnhe/sonokai",
		name = "sonokai",
		lazy = false,
		priority = 1000,
		config = function()
			vim.g.sonokai_style = "shusia"
			vim.g.sonokai_enable_italic = true
			-- vim.cmd.colorscheme 'sonokai'
		end,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- vim.cmd.colorscheme 'tokyonight-night'
		end,
	},
	{
		"eldritch-theme/eldritch.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
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
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
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
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
			-- vim.cmd.colorscheme 'catppuccin-macchiato'
		end,
	},
	{
		"savq/melange-nvim",
		name = "melange",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
			-- vim.cmd.colorscheme 'melange'
		end,
	},
	{
		"HoNamDuong/hybrid.nvim",
		lazy = false,
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
		lazy = false,
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
	{ "rose-pine/neovim", name = "rose-pine", lazy = false, priority = 1000 },
	{
		"AlexvZyl/nordic.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("nordic").load()
		end,
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000,
		config = function()
			require("everforest").setup({
				transparent = true,
				background = "hard",
				transparent_background_level = 2,
			})
		end,
	},
}
