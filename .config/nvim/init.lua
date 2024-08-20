if vim.g.vscode then
	require("vscode.vscodeinit")
else
	require("custom.set")

	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	end ---@diagnostic disable-next-line: undefined-field
	vim.opt.rtp:prepend(lazypath)
	require("lazy").setup({
		change_detection = {
			notify = false,
		},
		import = "custom.plugins",

		-- ui = {
		-- 	-- If you are using a Nerd Font: set icons to an empty table which will use the
		-- 	-- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
		--  -- I do be having a nerdfont
		-- 	icons = vim.g.have_nerd_font and {} or {
		-- 		cmd = "⌘",
		-- 		config = "🛠",
		-- 		event = "📅",
		-- 		ft = "📂",
		-- 		init = "⚙",
		-- 		keys = "🗝",
		-- 		plugin = "🔌",
		-- 		runtime = "💻",
		-- 		require = "🌙",
		-- 		source = "📄",
		-- 		start = "🚀",
		-- 		task = "📌",
		-- 		lazy = "💤 ",
		-- 	},
		-- },
	})
	require("custom.plugins.colorscheme").SetColorschemeFromFile()
	vim.cmd("doautocmd User ColorschemeLoaded") -- I set up some plugins to work off this
	-- The line beneath this is called `modeline`. See `:help modeline`
	-- -vim: ts=2 sts=2 sw=2 et
end
