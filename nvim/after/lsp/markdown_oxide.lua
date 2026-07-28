local capabilities = vim.lsp.protocol.make_client_capabilities()

return {
  capabilities = vim.tbl_deep_extend(
    'force',
    capabilities,
    {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    }
  ),
  on_attach = function(client, bufnr)
    -- setup Markdown Oxide daily note commands
    if client.name == "markdown_oxide" then
      vim.api.nvim_create_user_command(
        "Daily",
        function(args)
          local input = args.args
          client:exec_cmd({ command = "jump", arguments = { input } })
        end,
        { desc = 'Open daily note', nargs = "*" }
      )
      vim.keymap.set("n", "<leader>nd", "<cmd>Daily today<CR>", { desc = "NOTES: DAILY" })
      vim.keymap.set("n", "<leader>ny", "<cmd>Daily yesterday<CR>", { desc = "NOTES: YESTERDAY" })
      vim.keymap.set("n", "<leader>nt", "<cmd>Daily tomorrow<CR>", { desc = "NOTES: TOMORROW" })
    end
  end
}
