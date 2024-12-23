return {
	{
		-- https://github.com/shellRaining/hlchunk.nvim?tab=readme-ov-file
		"shellRaining/hlchunk.nvim",
    -- enabled = false,
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
}
