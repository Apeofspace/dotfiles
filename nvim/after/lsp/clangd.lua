return {
  cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc", "--fallback-style=google" },
}

-- turns out this needs to be in /after/lsp to make sure this take precedence over whats in nvim-lspconfig
