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
      disableOrganizeImports = true, -- ruff organizes imports
      -- analysis = { ignore = { '*' } }, -- ruff does linting
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "openFilesOnly",
        typeCheckingMode = "basic",
        diagnosticSeverityOverrides = {
          reportOptionalMemberAccess = false, -- "warning"
        },
      },
    },
  },
}
check_installed_and_enable("basedpyright", "basedpyright-langserver")

vim.lsp.config.ruff = {
  init_options = {
    settings = {
      lint = {
        enable = false, -- use basedpyright for linting, ruff for formatting
      }
    },
  }
}
check_installed_and_enable("ruff", "ruff")

vim.lsp.config.lua_ls = {
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
check_installed_and_enable("lua_ls", "lua-language-server")

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

    -- clangd switch header
    if client.name == "clangd" then
      map("gh", ":LspClangdSwitchSourceHeader<CR>", "Switch Source/Header")
    end

    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
    -- FIX this stopped working some time ago and now doesnt work LMAO
    if client and client.server_capabilities.documentHighlightProvider then
      local hl_gr = vim.api.nvim_create_augroup('bold_hl_group', { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = hl_gr,
        callback = vim.lsp.buf.document_highlight,
      })
      -- When you move your cursor, the highlights will be cleared
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = hl_gr,
        callback = vim.lsp.buf.clear_references,
      })
      -- remove autocmd when detached
      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('bold_hl_group', { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'bold_hl_group', buffer = event2.buf }
        end,
      })
    end
  end,
})
