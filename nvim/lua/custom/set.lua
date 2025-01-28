vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.

vim.opt.undofile = true
if vim.loop.os_uname().sysname == "Windows" or vim.loop.os_uname().sysname == "Windows_NT" then
	vim.opt.undodir = os.getenv("HOMEPATH") .. "/.nvim/undodir"
elseif vim.loop.os_uname().sysname == "Linux" then
	vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
end

-- no swap file, auto sync instances
vim.opt.autoread = true
vim.opt.swapfile = false

-- incsearch
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split" -- show changes on split
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- reset hl with esc

vim.opt.signcolumn = "yes"
vim.opt.foldcolumn = "auto"
vim.opt.list = false -- to mark tabs and spaces with symbols
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "␣" }
vim.opt.updatetime = 250 -- swap file written after than many ms
vim.opt.timeoutlen = 500 -- timeout for a keymap sequence
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true -- Highlight the text line of the cursor
-- vim.opt.scrolloff = 40
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"
vim.opt.wrap = false

vim.opt.breakindent = true
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- vim.lsp.inlay_hint.enable()

-- conceal level for obsidian nvim mainly
vim.opt.conceallevel = 0

-- allow unsaved buffers to be hidden
vim.opt.hidden = true

-- spellchecking
vim.opt.spell = false
vim.opt.spelllang = "en,ru" --have netrw enabled to auto download this

-- set terminal title to filename and to "bash" when exiting
vim.opt.titleold = "bash"
vim.opt.title = true
local title = function()
	local dir = ""
	for w in string.gmatch(vim.fn.getcwd(), "/.[^/]+") do
		-- only the last occurance in dir
		dir = w
	end
	dir = string.gsub(dir, "/", "")
	return "NVIM | " .. dir
end
vim.opt.titlestring = title()

-- don't continue comment when hitting newline
vim.api.nvim_create_autocmd("FileType", {
	pattern = "*",
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})

-- highlight when yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- don't remove autoindent when changing lines on empty line
vim.opt.cpoptions:append("I")
-- this is hack to automatically indent empty lines with correct indentation
local autoindent_empty_line = function(key)
	-- local line = vim.fn.getline(".")
	local line = vim.fn.getline("."):gsub("^%s+", "") -- get line and trim whitespaces
	if line == "" then
		return '"_cc'
	else
		return key
	end
end
-- stylua: ignore start
vim.keymap.set("n", "i", function() return autoindent_empty_line("i") end, { expr = true, noremap = true })
vim.keymap.set("n", "a", function() return autoindent_empty_line("a") end, { expr = true, noremap = true })
-- stylua: ignore stop
-- Diagnostic keymaps
vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>gq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- move selected lines up/down (now handled by mini.move)
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- paste by default doesnt copy to buffer 
vim.keymap.set({ "v" }, "p", [["_dp]], { noremap = true })
vim.keymap.set({ "v" }, "P", [["_dP]], { noremap = true })
vim.keymap.set("n", "<leader>pp", [[viw"_dp]], { noremap = true, desc = "Replace word under cursor with buffer" })
vim.keymap.set("n", "<leader>pP", [[viw"_dP]], { noremap = true, desc = "Replace word under cursor with buffer" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { noremap = true, desc = "Delete to void" })

-- experimental switch ctrl-d/u and d/u to lower finder stress
-- this should also be remapped in neoscroll
-- vim.keymap.set({ "n", "v" }, "d", "<C-d>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "u", "<C-u>", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<C-d>", "d", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<C-u>", "u", { noremap = true })


-- save file with < C-s >
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>")

-- moving splits with leader
vim.keymap.set({ "n", "v" }, "<leader>h", "<C-w>H", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>j", "<C-w>J", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>k", "<C-w>K", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>l", "<C-w>L", { noremap = true })
-- moving between splits
-- vim.keymap.set({ "n", "v" }, "<C-h>", "<C-w>h", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<C-j>", "<C-w>j", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<C-k>", "<C-w>k", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<C-l>", "<C-w>l", { noremap = true })

--<C-W> to <leader>W
vim.keymap.set({ "n", "v" }, "<leader>w", "<C-w>", { noremap = true })

-- remap ctrl-u to nothing (to avoid undoing while trying to yank or paste)
vim.keymap.set({ "i" }, "<C-u>", "<nop>", { desc = "fucking nothing" })
-- remap ctrl-ы to nothing (to avoid undoing while trying to save)
vim.keymap.set({ "n" }, "1099;133u", "<nop>", { desc = "fucking nothing" })

-- source current file
vim.keymap.set({ "n" }, "<leader>x", ":source %<CR>", { desc = "Source this file" })

-- use JQ to format json file (who cares honestly)
-- vim.keymap.set({ "n" }, "<leader>gj", [[:%!jq '.'<CR>]], { desc = "Format file with jq" })
-- vim.keymap.set({ "v" }, "<leader>gj", [[:'<,'>!jq '.'<CR>]], { desc = "Format selection with jq" })

-- center of screen on halfpage movements
-- vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
-- vim.keymap.set({ "n", "v" }, "G", "Gzz", { noremap = true })
