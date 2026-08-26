return {
  settings = {
    lint = {
      -- this weirdly doesn't work anymore
      enable = false,
    }
  },
  on_attach = function(client, bufnr)
    if client.name == 'ruff' then
      -- false means don't advertice capabilities
      -- nil means capabilities don't exist at all
      -- somehow ruff now ignores false
      client.server_capabilities.hoverProvider = nil
      client.server_capabilities.diagnosticProvider = nil -- disable all shit

      -- workaround for ruff dynamic advertising of capabilities making it not register normally
      vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { buffer = bufnr, desc = "LSP: Format with LSP" })

      -- this here long ass autocommand makes it so ruff auto organizeImports on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function(args)
          local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
          ---@diagnostic disable-next-line: inject-field
          params.context = {
            only = { "source.organizeImports.ruff" },
            diagnostics = {},
          }
          local result = client:request_sync("textDocument/codeAction", params, 3000, args.buf)

          for _, action in pairs(result and result.result or {}) do
            if action.edit or action.command then
              -- already resolved
            elseif action.data then
              local resolved = client:request_sync(
                "codeAction/resolve",
                action,
                3000,
                args.buf
              )

              action = resolved and resolved.result or action
            end

            if action.edit then
              vim.lsp.util.apply_workspace_edit(
                action.edit,
                client.offset_encoding
              )
            elseif action.command then
              client:exec_cmd(action.command, {
                bufnr = args.buf,
              })
            end
          end
        end,
      })
      -- ugh
    end
  end
}
