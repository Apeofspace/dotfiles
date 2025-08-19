-- WARN this piece of shit of a hidden control plugin (like all of falkes garbage)
-- for no reason whatsoever adds signature help window to completion
-- what buisiness does this plugin have with completion engine

-- it probably slows the shit out of neovim too

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  -- enabled = false,
  opts = {
    lsp = {
      -- -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      -- override = {
      -- 	["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      -- 	["vim.lsp.util.stylize_markdown"] = true,
      -- },
      signature = { auto_open = { enabled = false } } -- this is for blink
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false,        -- use a classic bottom cmdline for search
      command_palette = true,       -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = false,           -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = true,        -- add a border to hover docs and signature help
    },
  },
  dependencies = { "MunifTanjim/nui.nvim" },
}
