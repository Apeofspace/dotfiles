local M = {
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

return M
