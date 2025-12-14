local M = {
  { "neovim/nvim-lspconfig" },
  { "mason-org/mason.nvim", opts = {} },
  -- {"WhoIsSethDaniel/mason-tool-installer.nvim"},
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
        "clangd",
        "basedpyright",
        "ruff",
        "zls"
      }
    }

  },
}

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("cool-lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- MAPPINGS
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("<leader>r", vim.lsp.buf.rename, "[R]ename")
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    map("K", vim.lsp.buf.hover, "Hover Documentation")
    map("<leader>th", function() -- toggle inlay_hints
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
      if vim.lsp.inlay_hint.is_enabled() == true then
        vim.notify("Inlay hints enabled")
      else
        vim.notify("Inlay hints disabled")
      end
    end, "[T]oggle Inlay [H]ints")
    -- format with LSP
    if client.server_capabilities.documentFormattingProvider then
      map("<leader>f", vim.lsp.buf.format, "Format with LSP")
    end
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
    if client and client.server_capabilities.documentHighlightProvider then
      local hl_gr = vim.api.nvim_create_augroup('bold_hl_group', { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = hl_gr,
        callback = vim.lsp.buf.document_highlight,
        -- this requires some highlights to be defined check :h document_highlight
      })
      -- When you move your cursor, the highlights will be cleared
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = hl_gr,
        callback = vim.lsp.buf.clear_references,
      })
      -- remove autocmd when detached
      vim.api.nvim_create_autocmd('LspDetach', {
        group = hl_gr,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'bold_hl_group', buffer = event2.buf }
        end,
      })
    end
  end,
})


return M
