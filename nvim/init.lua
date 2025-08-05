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

	local active_scheme = require("custom.plugins.colorscheme").read_colorscheme()

	require("lazy").setup({
		change_detection = {
			notify = false,
		},
		import = "custom.plugins",
		install = { colorscheme = active_scheme },
	})

	if active_scheme then
		vim.cmd("colorscheme " .. active_scheme)
	end

	require("custom.lsp") -- config LSP servers

	-- WARN automapping cant handle lazy loaded plugins
	require("langmapper").automapping({ global = true, buffer = true })
	-- require("custom.scopehighlight")
end
