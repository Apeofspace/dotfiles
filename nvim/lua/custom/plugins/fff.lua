return {
	"dmtrKovalenko/fff.nvim",
	build = "cargo build --release",
	opts = {},
	keys = {
		{
			"ff", -- try it if you didn't it is a banger keybinding for a picker
			function()
				-- require("fff").find_in_git_root() -- or find_in_git_root() if you only want git files
        -- the find_files breaks if you also try to find files in a specific cwd
				require("fff").find_files() -- or find_in_git_root() if you only want git files
			end,
			desc = "Open file picker",
		},
	},
}
