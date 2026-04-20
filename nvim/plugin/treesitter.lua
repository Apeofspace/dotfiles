vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

local ensure_installed = {
  "bash",
  "c",
  "cmake",
  "diff",
  "go",
  "html",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
  "zig"
}

local ts = require("nvim-treesitter")
ts.install(ensure_installed)

-- it must be in a group. also this is the only way it works for some reason
local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  desc = "Enable TreeSitter highlighting",
  callback = function(ev)
    local ft = ev.match
    local lang = vim.treesitter.language.get_lang(ft) or ft
    local buf = ev.buf
    pcall(vim.treesitter.start, buf, lang)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
