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

-- incsearch
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split" -- show changes on split
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- reset hl with esc

vim.opt.signcolumn = "yes"
vim.opt.list = false -- to mark tabs and spaces with symbols
vim.opt.listchars = { tab = "> ", trail = "·", nbsp = "␣" }
vim.opt.updatetime = 250 -- swap file written after than many ms
vim.opt.timeoutlen = 300 -- timeout for a keymap sequence
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.cursorline = true -- Highlight the text line of the cursor
vim.opt.scrolloff = 40

vim.opt.colorcolumn = "80"
vim.opt.wrap = false

vim.opt.breakindent = true
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.lsp.inlay_hint.enable()

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

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>ge", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>gq", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- move selected lines up/down (now handled by mini.move)
-- vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { noremap = true })
-- vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { noremap = true })

-- paste by default doesnt copy to buffer (p and P are flipped for visual mode)
vim.keymap.set({ "v" }, "p", [["_dP]], { noremap = true })
vim.keymap.set({ "v" }, "P", [["_dp]], { noremap = true })
vim.keymap.set("n", "<leader>pp", [[viw"_dP]], { noremap = true, desc = "Replace word under cursor with buffer" })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { noremap = true, desc = "Delete to void" })

-- save file with < C-s >
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>")

-- moving splits with leader
vim.keymap.set({ "n", "v" }, "<leader>h", "<C-w>H", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>j", "<C-w>J", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>k", "<C-w>K", { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>l", "<C-w>L", { noremap = true })
-- moving between splits with Ctrl
vim.keymap.set({ "n", "v" }, "<C-h>", "<C-w>h", { noremap = false })
vim.keymap.set({ "n", "v" }, "<C-j>", "<C-w>j", { noremap = false })
vim.keymap.set({ "n", "v" }, "<C-k>", "<C-w>k", { noremap = false })
vim.keymap.set({ "n", "v" }, "<C-l>", "<C-w>l", { noremap = false })

-- vim.keymap.set({ "n", "v" }, "q", "<nop>", { desc = "fucking nothing" })
-- remap ctrl-u to nothing (to avoid undoing while trying to yank or paste)
vim.keymap.set({ "n", "v", "i" }, "<C-u>", "<nop>", { desc = "fucking nothing" })

-- use JQ to format json file
vim.keymap.set({ "n" }, "<leader>gj", [[:%!jq '.'<CR>]], { desc = "Format file with jq" })
vim.keymap.set({ "v" }, "<leader>gj", [[:'<,'>!jq '.'<CR>]], { desc = "Format selection with jq" })

-- center of screen on halfpage movements
vim.keymap.set({ "n", "v" }, "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set({ "n", "v" }, "G", "Gzz", { noremap = true })
