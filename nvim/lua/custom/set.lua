-- LANGMAP
local function escape(str)
  -- You need to escape these characters to work correctly
  local escape_chars = [[;,."|\]]
  return vim.fn.escape(str, escape_chars)
end

-- Recommended to use lua template string
local en = [[`qwertyuiop[]asdfghjkl;'zxcvbnm]]
local ru = [[ёйцукенгшщзхъфывапролджэячсмить]]
local en_shift = [[~QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>]]
local ru_shift = [[ËЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ]]

vim.opt.langmap = vim.fn.join({
  -- | `to` should be first     | `from` should be second
  escape(ru_shift) .. ";" .. escape(en_shift),
  escape(ru) .. ";" .. escape(en),
}, ",")
-- LANGMAP

vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 8
vim.opt.expandtab = true -- use spaces instead of tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.mouse = "a"
vim.opt.showmode = false -- I already show that in lualine

-- vim.cmd("set clipboard+=unnamedplus")
vim.opt.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.opt.foldmethod = "manual"

-- save undo history to a file
vim.opt.undofile = true
if vim.loop.os_uname().sysname == "Windows" or vim.loop.os_uname().sysname == "Windows_NT" then
  vim.opt.undodir = os.getenv("HOMEPATH") .. "/.nvim/undodir"
elseif vim.loop.os_uname().sysname == "Linux" then
  vim.opt.undodir = os.getenv("HOME") .. "/.nvim/undodir"
end

-- no swap file, auto sync instances
vim.opt.autoread = true
vim.opt.swapfile = false
vim.opt.updatetime = 60 -- this both for swapfile (which is disabled) and CursorHold which is used for some plugins

-- incsearch
vim.opt.inccommand = "split" -- preview replace changes on a split
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>") -- reset hl with esc

vim.opt.signcolumn = "yes"
-- vim.opt.foldcolumn = "auto"
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.wrap = false

-- multiline diagnostic messages
vim.diagnostic.config({
  virtual_text = true, -- oneline
  -- virtual_lines = true, -- multiline
})

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

-- NOTE this is done now by "rachartier/tiny-glimmer.nvim"
-- -- highlight briefly when yanking
-- vim.api.nvim_create_autocmd("TextYankPost", {
--   desc = "Highlight when yanking (copying) text",
--   group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
--   callback = function()
--     vim.highlight.on_yank()
--   end,
-- })

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
vim.keymap.set("n", "i", function() return autoindent_empty_line("i") end, { expr = true, noremap = true })
vim.keymap.set("n", "a", function() return autoindent_empty_line("a") end, { expr = true, noremap = true })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- paste by default doesnt copy to buffer
vim.keymap.set({ "v" }, "p", [["_dp]], { noremap = true })
vim.keymap.set({ "v" }, "P", [["_dP]], { noremap = true })
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { noremap = true, desc = "Delete to void" })
vim.keymap.set({ "n", "v" }, "<leader>x", [["_x]], { noremap = true, desc = "Delete to void" })

-- shortcuts
vim.keymap.set({ "n", "v" }, "<C-s>", ":w<CR>", { desc = "Save" })
-- vim.keymap.set({ "n", "v" }, "<C-q>", ":qa<CR>", { desc = "Quit" })
vim.keymap.set({ "n", "v" }, "<leader>w", "<C-w>", { noremap = true })
vim.keymap.set({ "n", "v" }, "<C-w>", "<nop>", { noremap = true }) -- remove normal mapping (doesnt work lol)

-- remap to nothing
vim.keymap.set({ "i" }, "<C-u>", "<nop>", { desc = "fucking nothing" })
vim.keymap.set({ "n" }, "1099;133u", "<nop>", { desc = "fucking nothing" })
vim.keymap.set({ "n", "v", "x" }, "s", "<nop>")  -- s does nothing as its the same as c
vim.keymap.set({ "n", "v", "x" }, "S", "<nop>")  -- use it for something else instead
-- vim.keymap.set({ "n", "v", "x" }, "q:", ":q")                   -- fuck that
-- remapping q works different from other keymaps. because q: nonremapped doesnt wait for : input
-- if you remap however it starts waiting which is annoying

vim.keymap.set({ "n", "v", "x" }, "q", "<nop>")                 -- macro on Q
vim.keymap.set({ "n", "v", "x" }, "Q", "q", { noremap = true }) -- macro on Q

-- somehow it doesnt work properly on load. something with sessions again
vim.api.nvim_create_autocmd("BufWinEnter", {
  desc = "Always move help buffers to a vertical split on the right",
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "help" or vim.bo.filetype == "man" then
      vim.schedule(function()
        vim.cmd("wincmd L")
      end)
    end
  end,
})

-- check out this shit. its better than noice
-- https://neovim.io/doc/user/cmdline.html#cmdline-autocompletion
