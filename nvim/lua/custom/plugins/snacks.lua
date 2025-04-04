-- attempts to make dynamic positioning,
-- but i need position float and not left and right and then do offset somehow
local function dynamic_picker_pos()
	-- Get the current window's position and dimensions
	local winid = vim.api.nvim_get_current_win()
	local win_config = vim.api.nvim_win_get_config(winid)
	local win_pos = vim.api.nvim_win_get_position(winid)

	-- Determine if the current window is on the left or right side of the screen
	local is_left_split = win_pos[2] == 0 -- If the window starts at column 0, it's a left split

	-- Set the picker position based on the current split layout
	local picker_position
	if is_left_split then
		picker_position = "right" -- Open picker on the right if current split is on the left
	else
		picker_position = "left" -- Open picker on the left if current split is on the right or no splits
	end
	return picker_position
end

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
		rename = { enabled = true }, -- oil does this
		-- scroll = { enabled = not vim.g.neovide, easing = "quadratic" }, -- doesnt look as good as neoscroll, bad at file top and bot
		-- lazygit = { enabled = false }, -- neogit arguably better
		-- scratch = { enabled = false },
		-- dim = { enabled = false },
		words = { enabled = true }, -- same as * and #
		input = { enabled = true }, -- doesnt work with vim.fn.input (which is the : )
		bigfile = { enabled = true },
		picker = { enabled = true },
		image = { enabled = true }, -- image preview
		notifier = { enabled = true, style = "compact" },
		quickfile = { enabled = true },
		-- explorer = { enabled = true, replace_netrw = true }, -- much worse than both oil and mini.files
		indent = {
			enabled = true,
			only_scope = true,
			only_current = true,
			chunk = {
				enabled = true,
				-- hl = "CursorLine",
			},
			indent = { enabled = false },
			animate = { enabled = false },
		},
	},
	keys = {
    --stylua: ignore start
    -- find files
    { "/F", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "/b", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "/n", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "/f", function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>op", function() Snacks.picker.projects() end, desc = "Projects" },
    -- { "<leader>e", function() Snacks.explorer({ sources = { explorer = { follow_file = false, focus = "input", jump = {close = true} } } }) end, desc = "File Explorer" },
    -- git
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gh", function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
		-- { "<leader>gG", function() Snacks.lazygit() end, desc = "Lazygit" },
    -- search
    { "//", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "/c", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "/g", function() Snacks.picker.grep() end, desc = "Grep" },
    { '/s', function() Snacks.picker.search_history() end, desc = "Search History" },
    { "/e", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "/h", function() Snacks.picker.help() end, desc = "Help Pages" },
    { "/H", function() Snacks.picker.highlights() end, desc = "Highlights" },
    { "/k", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "/r", function() Snacks.picker.resume() end, desc = "Resume search" },
    { "<leader>cs", function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Command History" },
    { '/"', function() Snacks.picker.registers() end, desc = "Registers" },
    { "/i", function() Snacks.picker.icons() end, desc = "Icons for nerds" },
    { "/p", function() Snacks.picker.spelling() end, desc = "Spelling" },
    -- LSP
    { "gd", function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD", function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "/d", function() Snacks.picker.lsp_symbols(
      {
        layout =
        {preset = "vscode",
          preview = "main",
          layout = {
            backdrop = 50,
            position ="float",
            border = "rounded", height = 0.35, width=0.2, min_width=40,
          }
        }
      }
    ) end, desc = "LSP Symbols" },
    { "/w", function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
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
				vim.keymap.set({ "n", "v", "x" }, "/", "<nop>") -- disable normal search
			end,
		})
		-- rename integration with minifiles
		vim.api.nvim_create_autocmd("User", {
			pattern = "MiniFilesActionRename",
			callback = function(event)
				Snacks.rename.on_rename_file(event.data.from, event.data.to)
			end,
		})
	end,
}

return M
