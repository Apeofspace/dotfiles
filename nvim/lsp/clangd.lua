local M = {
  cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc", "--fallback-style=google" },
  settings = {
    signel_file_support = true,
  },
}

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup('lsp_attach_map_clangdswitch', { clear = true }),
--   callback = function(args)
--     local client = vim.lsp.get_client_by_id(args.data.client_id)
--     if client == nil then
--       return
--     end
--     -- clangd switch header
--     if client.name == "clangd" then
--       map("gh", ":LspClangdSwitchSourceHeader<CR>", "Switch Source/Header")
--     end
-- })


return M
