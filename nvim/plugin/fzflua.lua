vim.pack.add({
  "https://github.com/nvim-mini/mini.nvim",
  "https://github.com/ibhagwan/fzf-lua",
})

local map = vim.keymap.set
local fzf = require("fzf-lua")

require("fzf-lua").setup({
  winopts = {
    border = "rounded",
  },
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
map("n", "<leader>cs", fzf.colorschemes, { desc = "Colorschemes" })
map("n", "<leader>sp", fzf.spell_suggest, { desc = "Spelling" })

-- LSP
map("n", "gd", fzf.lsp_definitions, { desc = "Goto Definition" })
map("n", "<leader>sc", fzf.lsp_references, { desc = "References" })
map("n", "<leader>sw", fzf.lsp_live_workspace_symbols, { desc = "Workspace Symbols" })
map("n", "<leader>se", fzf.diagnostics_document, { desc = "Diagnostics" })
map("n", "<leader><leader>", function()
  fzf.lsp_document_symbols({ winopts = { height = 0.5, width = 0.3, } })
end, { desc = "LSP Symbols (file)" })

-- weird shit that i never use
map("n", "<leader>s:", fzf.command_history, { desc = "Command History" })
map("n", "<leader>sm", fzf.marks, { desc = "Marks" })
map("n", "<leader>sb", fzf.buffers, { desc = "Buffers" })
map("n", "gD", fzf.lsp_declarations, { desc = "Goto Declaration" })
map("n", "gI", fzf.lsp_implementations, { desc = "Goto Implementation" })
