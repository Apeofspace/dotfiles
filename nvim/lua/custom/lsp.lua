local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities) -- this extends

vim.lsp.config("*", {
	capabilities = capabilities,
	root_markers = { ".git" },
})

-- TODO these needs to be moved in separate files under ./after/lsp/

vim.lsp.config.clangd = {
	cmd = { "clangd", "--query-driver=/usr/bin/arm-none-eabi-gcc" },
	filetypes = { "c", "cpp" },
	root_markers = { "compile_commands.json" },
	settings = {
		signel_file_support = true,
	},
}

vim.lsp.config.basedpyright = {
	cmd = { "basedpyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	settings = {
		basedpyright = {
			disableOrganizeImports = true, -- ruff
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
			hint = { enabled = true },
		},
	},
}

-- I dont care about that one enough
vim.lsp.config.cmakels = {
	cmd = { "cmake-language-server" },
	filetypes = { "cmake" },
	root_markers = { "CMakePresets.json", "CTestConfig.cmake", ".git", "build", "cmake" },
	init_options = {
		buildDirectory = "build",
	},
}

-- I dont care about that one enough
vim.lsp.config.marksman = {
	cmd = { "marksman" },
	filetypes = { "markdown" },
}

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
			map("<leader>F", vim.lsp.buf.format, "Format with LSP")
		end

		-- clangd switch header wrapper stolen from lsp-config
		if client.name == "clangd" then
			local function switch_source_header(bufnr)
				local method_name = "textDocument/switchSourceHeader"
				local client_clangd = vim.lsp.get_clients({ bufnr = bufnr, name = "clangd" })[1]
				if not client_clangd then
					return vim.notify(
						("method %s is not supported by any servers active on the current buffer"):format(method_name)
					)
				end
				local params = vim.lsp.util.make_text_document_params(bufnr)
				client.request(method_name, params, function(err, result)
					if err then
						error(tostring(err))
					end
					if not result then
						vim.notify("corresponding file cannot be determined")
						return
					end
					vim.cmd.edit(vim.uri_to_fname(result))
				end, bufnr)
			end
			map("gs", function()
				switch_source_header(event.buf)
			end, "Switch Source/Header")
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

vim.lsp.config.zls = {
	cmd = { "zls" },
	filetypes = { "zig" },
	-- root_dir = { "zls.json", "build.zig", ".git" },
	single_file_support = true,
}

-- ENABLE SERVERS
local enabled_lsp_servers = {
	clangd = "clangd",
	cmakels = "cmake-language-server",
	basedpyright = "basedpyright-langserver",
	ruff = "ruff check",
	luals = "lua-language-server",
	zls = "zls",
	-- marksman = "marksman", -- honestly what does it even do
}

for server_name, lsp_executable in pairs(enabled_lsp_servers) do
	if vim.fn.executable(lsp_executable) then
		vim.lsp.enable(server_name)
	else
		local msg = string.format(
			"Executable '%s' for server '%s' not found! Server will not be enabled",
			lsp_executable,
			server_name
		)
		vim.notify(msg, vim.log.levels.WARN, { title = "Nvim-config" })
	end
end

-- use nvim-lspconfig for default settings without loading the plugin itself
-- (i think)
return {
	"neovim/nvim-lspconfig",
	-- No need to load the plugin—since we just want its configs, adding the
	-- it to the `runtimepath` is enough.
	lazy = true,
	init = function() -- use init isntead of config
		local lspConfigPath = require("lazy.core.config").options.root .. "/nvim-lspconfig"
		-- INFO `prepend` ensures it is loaded before the user's LSP configs, so
		-- that the user's configs override nvim-lspconfig.
		vim.opt.runtimepath:prepend(lspConfigPath)
	end,
}
