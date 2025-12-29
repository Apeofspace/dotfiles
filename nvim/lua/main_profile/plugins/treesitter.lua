-- the only thing it does is autoinstalls treesitter packs
local M = {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    branch = "main",
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      local ts = require("nvim-treesitter")
      ts.install({
        "bash",
        "c",
        "html",
        "lua",
        "markdown",
        "markdown_inline",
        "vim",
        "vimdoc",
        "python",
        "go",
        "diff",
        "regex",
      }, { summary = false })
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { '<filetype>' },
        callback = function()
          vim.treesitter.start()
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
