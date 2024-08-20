-- https://github.com/otavioschwanck/arrow.nvim?tab=readme-ov-file#advanced-setup
-- return {
-- 	"otavioschwanck/arrow.nvim",
-- 	opts = {
-- 		show_icons = true,
-- 		leader_key = "<leader><leader>", -- Recommended to be a single key
-- 		buffer_leader_key = "<leader>m", -- Per Buffer Mappings
-- 	},
-- }

return {
	"otavioschwanck/arrow.nvim",
	config = function()
		require("arrow").setup({
			show_icons = true,
			leader_key = "<leader><leader>", -- Recommended to be a single key
			buffer_leader_key = "<leader>m", -- Per Buffer Mappings
		})
		-- local statusline = require("arrow.statusline")
		-- statusline.is_on_arrow_file() -- return nil if current file is not on arrow.  Return the index if it is.
		-- statusline.text_for_statusline() -- return the text to be shown in the statusline (the index if is on arrow or "" if not)
		-- statusline.text_for_statusline_with_icons() -- Same, but with an bow and arrow icon ;D
	end,
}
