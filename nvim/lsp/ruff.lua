local M = {
  settings = {
    init_options = {
      settings = {
        lint = {
          enable = false, -- use basedpyright for linting, ruff for formatting
        }
      },
    }
  },
  on_attach = function(client, bufnr)
    _ = bufnr
    if client.name == 'ruff' then
      client.server_capabilities.hoverProvider = false
    end
  end
}

return M
