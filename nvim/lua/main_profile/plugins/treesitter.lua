-- the only thing it does is autoinstalls treesitter packs
local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      local ts = require("nvim-treesitter")
      local ts_cfg = require("nvim-treesitter.config")
      local parsers = require("nvim-treesitter.parsers")
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
        "zig",
      }
      local ignored_ft = { "checkhealth", "lazy", "mason", "undotree", }

      ts.install(ensure_installed)

      local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        desc = "Enable TreeSitter highlighting",
        callback = function(ev)
          local ft = ev.match

          if vim.tbl_contains(ignored_ft, ft) then
            return
          end

          local lang = vim.treesitter.language.get_lang(ft) or ft
          local buf = ev.buf
          pcall(vim.treesitter.start, buf, lang)

          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    -- jumping between the matching opposing end of a Tree-sitter node, such as brackets, quotes, and more.
    "yorickpeterse/nvim-tree-pairs",
    enabled = true,
    opts = {},
  }
}
return M
