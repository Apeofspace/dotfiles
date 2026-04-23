return {
  settings = {
    lint = {
      -- this weirdly doesn't work anymore
      enable = false,
    }
  },
  on_attach = function(client, bufnr)
    _ = bufnr
    if client.name == 'ruff' then
      -- false means don't advertice capabilities
      -- nil means capabilities don't exist at all
      -- somehow ruff now ignores false
      client.server_capabilities.hoverProvider = nil
      -- client.server_capabilities.diagnosticProvider = nil
    end
  end
}
