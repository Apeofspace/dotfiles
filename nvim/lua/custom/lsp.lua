local check_installed_and_enable = function(name, executable)
  if vim.fn.executable(executable) then
    vim.lsp.enable(name)
  else
    local msg = string.format(
      "Executable '%s' for server '%s' not found! Server will not be enabled",
      executable,
      name
    )
    vim.notify(msg, vim.log.levels.WARN, { title = "Nvim-config" })
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities) -- this extends

vim.lsp.config("*", {
  capabilities = capabilities,
  root_markers = { ".git" },
})


vim.lsp.config.clangd = {
  cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc", "--fallback-style=google" },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json" },
  settings = {
    signel_file_support = true,
  },
}
check_installed_and_enable("clangd", "clangd")

-- need this for symbols untill ruff can do that too
vim.lsp.config.basedpyright = {
  settings = {
    basedpyright = {
      disableOrganizeImports = true,   -- ruff organizes imports
      analysis = { ignore = { '*' } }, -- ruff does linting
      -- analysis = {
      --   autoSearchPaths = true,
      --   useLibraryCodeForTypes = true,
      --   diagnosticMode = "openFilesOnly",
      --   typeCheckingMode = "basic",
      --   diagnosticSeverityOverrides = {
      --     reportOptionalMemberAccess = false, -- "warning"
      --   },
      -- },
    },
  },
}
check_installed_and_enable("basedpyright", "basedpyright-langserver")

vim.lsp.config.ruff = {
  settings = {},
}
check_installed_and_enable("ruff", "ruff")

vim.lsp.config.luals = {
  formatters = {
    ignoreComments = false,
  },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      signatureHelp = { enabled = true },
      hint = { enabled = true },
      diagnostics = {
        globals = {
          "vim",
          "require",
        },
      },
    },
  },
}
check_installed_and_enable("luals", "lua-language-server")

vim.lsp.config.zls = {
  single_file_support = true,
  settings = {},
}
check_installed_and_enable("zls", "zls")

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("cool-lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if not client then
      return
    end

    -- mappings
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map("<F2>", vim.lsp.buf.rename, "[R]e[n]ame")
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

    -- clangd switch header
    if client.name == "clangd" then
      map("gs", ":LspClangdSwitchSourceHeader<CR>", "Switch Source/Header")
    end

    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      -- When you move your cursor, the highlights will be cleared
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
