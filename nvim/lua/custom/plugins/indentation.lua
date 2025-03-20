return {

	{
		-- https://github.com/shellRaining/hlchunk.nvim?tab=readme-ov-file
		"shellRaining/hlchunk.nvim",
		enabled = true,
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({
				line_num = {
					enable = false,
				},
				chunk = {
					-- https://github.com/shellRaining/hlchunk.nvim/blob/main/docs/en/chunk.md#chunk_example1
					enable = true,
					duration = 0,
					delay = 0,
				},
				indent = {
					enable = false,
				},
			})
		end,
	},

	{
		"https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
	},

	{
		-- ne poluchaetsia =(
		"lukas-reineke/indent-blankline.nvim",
		enabled = false,
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {
			indent = {
				char = "", -- No indentation guides
				-- highlight = { "CursorColumn", "Whitespace" }, -- Use CursorLine highlight for the background
			},
			whitespace = {
				highlight = { "CursorLine" }, -- Use CursorLine highlight for the background
				remove_blankline_trail = false,
			},
			scope = {
				enabled = true,
				show_start = true,
				show_end = false,
				injected_languages = false,
				highlight = { "Function", "Label" },
				priority = 500,
			},
		},
	},
}
