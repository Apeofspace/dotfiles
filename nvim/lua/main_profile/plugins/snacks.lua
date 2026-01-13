local lsp_symbols_this_file = function()
  Snacks.picker.lsp_symbols(
    {
      layout = {
        preset = "vscode",
        preview = "main",
        layout = {
          backdrop = 50,
          position = "float",
          border = "rounded",
          height = 0.35,
          width = 0.2,
          min_width = 40,
        }
      }
    }
  )
end

local M = {
  "folke/snacks.nvim",
  priority = 1500,
  lazy = false,
  -- enabled = false,
  opts = {
    input = { enabled = true },                       -- doesnt work with vim.fn.input (which is the : )
    picker = { enabled = true },                      -- the only non useless part of this
    notifier = { enabled = true, style = "compact" }, -- worse than fidget bacause you can switch to it
    quickfile = { enabled = true },                   -- When doing nvim somefile.txt, it will render the file as quickly as possible, before loading your plugins.
    indent = { enabled = true, indent = { enabled = false }, scope = { only_current = true }, animate = { enabled = false } },
    statuscolumn = { enabled = true, folds = { open = true } },
    terminal = { enabled = true }, -- only for neovide
  },
  keys = {
    --stylua: ignore start
    -- PICKERS
    -- find files
    { "<leader>ss",       function() Snacks.picker.pickers() end,                                                    desc = "All pickers" },
    { "ff",               function() Snacks.picker.files() end,                                                      desc = "Find Files" },
    { "<leader>sf",       function() Snacks.picker.smart() end,                                                      desc = "Smart Find Files" },
    { "<leader>sb",       function() Snacks.picker.buffers() end,                                                    desc = "Buffers" },
    { "<leader>sn",       function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,                    desc = "Find Config File" },
    { "<leader>sd",       function() Snacks.picker.git_diff() end,                                                   desc = "Git changes (hunks)" },
    -- search
    { "<leader>/",        function() Snacks.picker.lines() end,                                                      desc = "Buffer Lines" },
    { "<leader>sc",       function() Snacks.picker.grep_word() end,                                                  desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>sg",       function() Snacks.picker.grep() end,                                                       desc = "Grep" },
    { "<leader>se",       function() Snacks.picker.diagnostics() end,                                                desc = "Diagnostics" },
    { "<leader>sh",       function() Snacks.picker.help() end,                                                       desc = "Help Pages" },
    { "<leader>sr",       function() Snacks.picker.resume() end,                                                     desc = "Resume search" },
    { "<leader>sm",       function() Snacks.picker.marks() end,                                                      desc = "Marks" },
    { "<leader>cs",       function() Snacks.picker.colorschemes() end,                                               desc = "Colorschemes" },
    { '<leader>s"',       function() Snacks.picker.registers() end,                                                  desc = "Registers" },
    { "<leader>si",       function() Snacks.picker.icons() end,                                                      desc = "Icons for nerds" },
    { "<leader>sp",       function() Snacks.picker.spelling() end,                                                   desc = "Spelling" },
    { "<leader>sk",       function() Snacks.picker.keymaps() end,                                                    desc = "Keymaps" },
    { "<leader>sH",       function() Snacks.picker.highlights() end,                                                 desc = "Highlights" },
    { "<leader>s:",       function() Snacks.picker.command_history() end,                                            desc = "Command History" },
    { '<leader>s/',       function() Snacks.picker.search_history() end,                                             desc = "Search History" },
    -- LSP
    { "gd",               function() Snacks.picker.lsp_definitions() end,                                            desc = "Goto Definition" },
    { "gD",               function() Snacks.picker.lsp_declarations() end,                                           desc = "Goto Declaration" },
    { "gr",               function() Snacks.picker.lsp_references() end,                                             nowait = true,                     desc = "References" },
    { "gI",               function() Snacks.picker.lsp_implementations() end,                                        desc = "Goto Implementation" },
    { "gy",               function() Snacks.picker.lsp_type_definitions() end,                                       desc = "Goto T[y]pe Definition" },
    { "<leader>N",        function() Snacks.notifier.show_history() end,                                             desc = "Notification History" },
    { "<leader>sw",       function() Snacks.picker.lsp_workspace_symbols() end,                                      desc = "LSP Workspace Symbols" },
    { "<leader><leader>", lsp_symbols_this_file,                                                                     desc = "LSP Symbols" },
    -- terminal
    { "<leader>tt",       function() Snacks.terminal(nil, { cwd = vim.uv.fs_realpath(vim.fn.expand('%:p:h')) }) end, desc = "Toggle Terminal" },
  },
}

return M
