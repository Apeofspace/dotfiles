vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/ibhagwan/fzf-lua",
})

local map = vim.keymap.set
local fzf = require("fzf-lua")

fzf.setup({
  winopts = {
    border = "rounded",
  },
  ui_select = function(fzf_opts, items)
    return vim.tbl_deep_extend("force", fzf_opts, {
      winopts = {
        width = 0.5,
        height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
        preview = { hidden = "hidden" },
      },
    })
  end
})

map("n", "<leader>ss", fzf.builtin, { desc = "All pickers" })
-- find files
map("n", "ff", fzf.files, { desc = "Find Files" })
map("n", "<leader>sn", function() fzf.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "NVIM config" })

-- search
map("n", "<leader>/", fzf.blines, { desc = "Buffer Lines" })
map("n", "<leader>sg", fzf.live_grep, { desc = "Grep" })
map("n", "<leader>sh", fzf.help_tags, { desc = "Help Pages" })
map("n", "<leader>sr", fzf.resume, { desc = "Resume search" })
map("n", "<leader>sp", fzf.spell_suggest, { desc = "Spelling" })
map("n", "<leader>sC", fzf.grep_cword, { desc = "Grep word under cursor" })

-- LSP
map("n", "gd", fzf.lsp_definitions, { desc = "Goto Definition" })
map("n", "gD", fzf.lsp_declarations, { desc = "Goto Declaration" })
map("n", "gI", fzf.lsp_implementations, { desc = "Goto Implementation" })
map("n", "<leader>sc", fzf.lsp_references, { desc = "References" })
map("n", "<leader>sw", fzf.lsp_live_workspace_symbols, { desc = "Workspace Symbols" })
map("n", "<leader>se", fzf.diagnostics_document, { desc = "Diagnostics document" })
map("n", "<leader>sE", fzf.diagnostics_workspace, { desc = "Diagnostics workspace" })
map("n", "<leader><leader>", function()
  fzf.lsp_document_symbols({ winopts = { height = 0.5, width = 0.3, preview = { hidden = "hidden" } } })
end, { desc = "LSP Symbols (file)" })
