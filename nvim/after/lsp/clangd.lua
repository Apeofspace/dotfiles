vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client.name == "clangd" then
      vim.keymap.set("n", "<leader>oh", "<cmd>LspClangdSwitchSourceHeader<CR>", { desc = "Switch Header/Source" })
    end
  end
})

return {
  cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc",
    "--fallback-style=google" },
}


--turns out this needs to be in / after / lsp to make sure this take precedence over whats in nvim - lspconfig
