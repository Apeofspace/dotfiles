local M = {
	"folke/snacks.nvim",
	priority = 1500,
	lazy = false,
	opts = {
		-- statuscolumn = {
		-- 	enabled = false,
		-- 	left = { "mark", "sign" }, -- priority of signs on the left (high to low)
		-- 	right = { "fold", "git" }, -- priority of signs on the right (high to low)
		-- 	folds = {
		-- 		open = true, -- show open fold icons (doesntwork lmao)
		-- 		git_hl = true, -- use Git Signs hl for fold icons
		-- 	},
		-- 	git = { patterns = { "GitSign", "MiniDiffSign" } },
		-- }, -- mini.diff does that better
		-- dashboard = { enabled = false }, -- what am I gay?
		-- zen = { enabled = false }, -- lmao my ass
		-- scope = { enabled = false }, -- bad treewalker
		-- terminal = { enabled = false }, -- not nice
		-- indent = { enabled = false }, -- worse than hlchunk
		-- rename = { enabled = false }, -- oil does this
		-- scroll = { enabled = not vim.g.neovide, easing = "quadratic" }, -- doesnt look as good as neoscroll, bad at file top and bot
		-- lazygit = { enabled = false }, -- neogit arguably better
		-- scratch = { enabled = false },
		words = { enabled = true }, -- same as * and #
		input = { enabled = true }, -- doesnt work with vim.fn.input (which is the : )
		bigfile = { enabled = true },
		picker = { enabled = true },
		image = { enabled = true }, -- image preview
		notifier = { enabled = true, style = "compact" },
		quickfile = { enabled = true },
		-- explorer = { enabled = true, replace_netrw = true }, -- much worse than both oil and mini.files
	},
	keys = {
    --stylua: ignore start
    -- find files
    { "<leader>sf", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>sn", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>sF", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>op", function() Snacks.picker.projects() end, desc = "Projects" },
    -- { "<leader>e", function() Snacks.explorer({ sources = { explorer = { follow_file = false, focus = "input", jump = {close = true} } } }) end, desc = "File Explorer" },
    -- git
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gh", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		-- { "<leader>gG", function() Snacks.lazygit() end, desc = "Lazygit" },
    -- search
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sc", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>s<leader>", function() Snacks.picker.grep() end, desc = "Grep" },
    { '<leader>ss', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>se", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sH", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume search" },
    { "<leader>cs", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { '<leader>s"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons for nerds" },
    { "<leader>sp", function() Snacks.picker.spelling() end, desc = "Spelling" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "<leader>sd", function() Snacks.picker.lsp_symbols({layout = {preset = "vscode", preview = "main", layout = {border = "rounded", height = 0.35, width=0.2, min_width=40}}}) end, desc = "LSP Symbols" },
    { "<leader>sw", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
    -- scratch
    -- { "<leader>.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    -- { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    -- Other
    { "<leader>Z",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "<leader>N",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Github Browse", mode = { "n", "v" } },
		-- { "<leader>cR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
		{ "]]",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
		{ "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
	},
	--stylua: ignore end
	init = function()
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (lazy-loaded)
				_G.dd = function(...)
					Snacks.debug.inspect(...)
				end
				_G.bt = function()
					Snacks.debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks for `:=` command

				-- Create some toggle mappings
				Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
				Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
				Snacks.toggle.treesitter():map("<leader>tT")
				-- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
				-- Snacks.toggle.inlay_hints():map("<leader>uh") -- already do this
			end,
		})
	end,
}

return M
