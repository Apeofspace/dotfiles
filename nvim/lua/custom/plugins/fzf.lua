-- this is quite a bit uglier than snacks picker, but at least its not folke
-- it also doesn't have frecency built-in so its a deal breaker

-- problems rn:
-- icons
-- obsidian with frecency
-- bit fugly

return {
  "ibhagwan/fzf-lua",
  enabled = false,
  opts = {},
  init = function()
    local fzf_lua = require("fzf-lua")
    vim.keymap.set("n", "<leader>sf", fzf_lua.files, { desc = "Search files" })
    vim.keymap.set("n", "<leader>ss", fzf_lua.builtin, { desc = "FZF" })
    vim.keymap.set("n", "<leader>sc", fzf_lua.grep_cword, { desc = "Grep selected" })
    vim.keymap.set("n", "<leader>sg", fzf_lua.live_grep_glob, { desc = "Grep live with glob" })
    vim.keymap.set("n", "<leader>sb", fzf_lua.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader><leader>", fzf_lua.grep_curbuf, { desc = "Search current buffer" })
    vim.keymap.set("n", "<leader>se", fzf_lua.diagnostics_workspace, { desc = "Workspace diagnostics" })
    vim.keymap.set("n", "<leader>sE", fzf_lua.diagnostics_document, { desc = "Buffer diagnostics" })
    vim.keymap.set("n", "<leader>sd", fzf_lua.lsp_document_symbols, { desc = "Buffer Symbols" })
    vim.keymap.set("n", "<leader>sw", fzf_lua.lsp_live_workspace_symbols, { desc = "Workspace Symbols (live query)" })
    vim.keymap.set("n", "<leader>ca", fzf_lua.lsp_code_actions, { desc = "Code actions" })
    vim.keymap.set("n", "<leader>sr", fzf_lua.resume, { desc = "Resume last search" })
    vim.keymap.set("n", "<leader>sh", fzf_lua.helptags, { desc = "Search help" })
    vim.keymap.set("n", "<leader>sp", fzf_lua.spell_suggest, { desc = "Spellcheck" })
    vim.keymap.set("n", "<leader>cs", fzf_lua.colorschemes, { desc = "Colorschemes" })
    vim.keymap.set("n", "<leader>sn", function() fzf_lua.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "FZF" })
    vim.keymap.set("n", "<leader>N", ":messages<CR>", { desc = "Message history" })
  end
}
