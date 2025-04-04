local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities) -- this extends

vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})

vim.lsp.config.clangd = {
	cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc" },
	filetypes = { "c", "cpp" },
	root_markers = { "compile_commands.json" },
	settings = {
		signel_file_support = true,
	},
}

vim.lsp.config.cmakels = {
	cmd = { "cmake-language-server" },
	filetype = { "cmake" },
}

vim.lsp.config.basedpyright = {
	cmd = { "basedpyright" },
	-- cmd = {"basedpyright-langserver"},
	filetypes = { "python" },
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- ruff
			analysis = {
				typeCheckingMode = "basic",
				diagnosticSeverityOverrides = {
					reportOptionalMemberAccess = false, -- "warning"
				},
			},
		},
	},
}

vim.lsp.config.ruff = {
	cmd = { "ruff check" },
	filetypes = { "python" },
	settings = {
		init_options = {
			settings = {
				lint = { enable = false }, -- DISABLE LINTING (use pyright)
				ignore = { "E501", "E231" },
				formatEnabled = true, -- use conform if false
				-- formatEnabled = false, -- use conform if false
				lineLength = 125,
			},
		},
	},
	capabilities = {
		hoverProvider = false, -- pyright
		signatureHelpProvider = false, -- pyright (not sure if this even works)
	},
}

vim.lsp.config.luals = {
	cmd = { "lua-language-server" },
	filetypes = { "lua" },
	-- root_markers = { ".luarc.json", ".luarc.jsonc" },
	telemetry = { enabled = false },
	formatters = {
		ignoreComments = false,
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			signatureHelp = { enabled = true },
		},
	},
}

vim.lsp.config.marksman = {
	cmd = { "marksman" },
	filetypes = { "markdown" },
}

vim.lsp.enable({ "clangd", "cmakels", "basedpyright", "ruff", "luals", "marksman" })

vim.keymap.set({ "n" }, "gs", ":ClangdSwitchSourceHeader<CR>", { noremap = true })
vim.keymap.set({ "n" }, "<F2>", vim.lsp.buf.rename, { noremap = true })
vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, { noremap = true })

return {
	{
		"williamboman/mason.nvim",
		opts = { ensure_installed = { "clangd", "cmake", "marksman", "basedpyright", "ruff", "lua_ls" } },
	},
	{ "WhoIsSethDaniel/mason-tool-installer.nvim", opts = { ensure_installed = { "stylua", "codespell" } } },
}
