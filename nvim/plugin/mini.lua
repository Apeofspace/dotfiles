vim.pack.add({ 'https://github.com/nvim-mini/mini.nvim' })

local moveopts = {
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = "<C-Left>",
    right = "<C-Right>",
    down = "<C-Down>",
    up = "<C-Up>",
    -- Move current line in Normal mode
    line_left = "<C-Left>",
    line_right = "<C-Right>",
    line_down = "<C-Down>",
    line_up = "<C-Up>",
  },
}
local hipatternsopts = {
  highlighters = {
    fixme = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
    shitcode = { pattern = "%f[%w]()SHITCODE()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    crutch = { pattern = "%f[%w]()CRUTCH()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsHack" },
    important = { pattern = "%f[%w]()IMPORTANT()%f[%W]", group = require("mini.hipatterns").compute_hex_color_group("#FF5C00", 'bg') },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
}
local miniclue = require("mini.clue")
local clueopts = {
  triggers = {
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    -- Built-in completion
    { mode = "i", keys = "<C-x>" },
    -- `g` key
    { mode = "n", keys = "g" },

    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },
    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },
    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  },
  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    { mode = "n", keys = "<Leader>m",  desc = "Markdown" },
    { mode = "n", keys = "<Leader>g",  desc = "GIT" },
    { mode = "n", keys = "<Leader>gd", desc = "Git diffview" },
    { mode = "n", keys = "<Leader>s",  desc = "PICKERS" },
    { mode = "n", keys = "<Leader>t",  desc = "Toggles" },
    { mode = "n", keys = "<Leader>w",  desc = "doesnt work for some reason" },
  },
  window = {
    delay = 0,
  },
}
local surroundopts = {
  mappings = {
    add = 'Sa',        -- Add surrounding in Normal and Visual modes
    delete = 'Sd',     -- Delete surrounding
    find = 'Sf',       -- Find surrounding (to the right)
    find_left = 'SF',  -- Find surrounding (to the left)
    highlight = 'Sh',  -- Highlight surrounding
    replace = 'Sr',    -- Replace surrounding

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
}
local aiopts = {
  n_lines = 500,
  mappings = {
    -- disable these to get way for build-in incremental selection
    around_next = '',
    inside_next = '',
    around_last = '',
    inside_last = '',
  }
}
local operatoropts = {
  { exchange = { prefix = "" } },
  replace = {
    prefix = 's',
    -- prefix = '<leader>r',
    -- reindent_linewise = true, -- Whether to reindent new text to match previous indent
  },
}
local commentopts = {
  options = {
    ignore_blank_line = true,
  },
}


require("mini.icons").setup({})
require("mini.ai").setup(aiopts)
require("mini.align").setup({}) -- press gA to start
require("mini.operators").setup(operatoropts)
require("mini.move").setup(moveopts)
require("mini.hipatterns").setup(hipatternsopts)
require("mini.clue").setup(clueopts)
require("mini.surround").setup(surroundopts)
require("mini.comment").setup(commentopts)
-- require("mini.pairs").setup() -- too basic in many ways. sucks
-- require("mini.animate").setup({}) -- kinda like neoscroll + smear?


local pick = require("mini.pick")
local extra = require("mini.extra")
extra.setup({})
pick.setup({})
-- pick.setup({ source = { show = pick.default_show } })
vim.keymap.set("n", "<leader>sf",
  function() pick.builtin.cli({ command = { "rg", "--files", "--color=never", "-uu" } }) end,
  { desc = "PICK: files" }) -- modify to search hidden
vim.keymap.set("n", "ff", pick.builtin.files, { desc = "PICK: project files" })
vim.keymap.set("n", "<leader>sg", pick.builtin.grep_live, { desc = "PICK: grep LIVE" })
vim.keymap.set("n", "<leader>sr", pick.builtin.resume, { desc = "PICK: resume" })
vim.keymap.set("n", "<leader>sb", pick.builtin.buffers, { desc = "PICK: buffers" })
vim.keymap.set("n", "<leader>sh", pick.builtin.help, { desc = "PICK: help" })
vim.keymap.set("n", "<leader>sk", extra.pickers.keymaps, { desc = "PICK: keymaps" })

vim.keymap.set("n", "<leader><leader>", function()
  extra.pickers.lsp({ scope = "workspace_symbol_live" })
end, { desc = "PICK: symbols" })

vim.keymap.set("n", "<leader>sc", function()
  extra.pickers.lsp({ scope = "references" })
end, { desc = "PICK: references" })

vim.keymap.set("n", "gd", function()
  extra.pickers.lsp({ scope = "definition" })
end, { desc = "PICK: definition" })

vim.keymap.set("n", "<leader>se", function()
  extra.pickers.diagnostic({ scope = "all" }) -- or "current"
end, { desc = "PICK: diagnostics" })

vim.keymap.set("n", "<leader>sp", function()
  extra.pickers.spellsuggest()
end, { desc = "PICK: spelling" })

vim.keymap.set("n", "<leader>sn", function()
  pick.builtin.cli({ command = { "rg", "--files", "--color=never", "-uu", vim.fn.stdpath("config") } })
end, { desc = "PICK: nvim config" })
