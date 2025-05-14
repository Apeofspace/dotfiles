local M = {
	{
		"mfussenegger/nvim-dap",
		enabled = false,
		dependencies = {
			{ "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
			"williamboman/mason.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"mfussenegger/nvim-dap-python",
			"theHamsta/nvim-dap-virtual-text",
			"jedrzejboczar/nvim-dap-cortex-debug",
		},
    --stylua: ignore start
		keys = {
			{ "<F5>", function() -- (Re-)reads launch.json if present
					-- if vim.fn.filereadable(".vscode/launch.json") then
					-- 	require("dap.ext.vscode").load_launchjs(nil, { cpptools = { "c", "cpp" } })
					-- end
					require("dap").continue()
				end,
        desc = "Debug: Start/Continue", },
			{ "<F6>", function() require("dap").pause() end, desc = "Debug: Pause", },
			{ "<F11>", function() require("dap").step_into() end, desc = "Debug: Step Into", },
			{ "<F10>", function() require("dap").step_over() end, desc = "Debug: Step Over", },
			{ "<S-F11>", function() require("dap").step_out() end, desc = "Debug: Step Out", },
			{ "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint", },
			{ "<leader>B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set Breakpoint", },
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			{ "<F7>", function() require("dapui").toggle() end, desc = "Debug: See last session result.", },
		},
		--stylua: ignore end
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("nvim-dap-virtual-text").setup()
			require("mason-nvim-dap").setup({
				-- reasonable debug configurations
				automatic_installation = true,
				-- You can provide additional configuration to the handlers,
				-- see mason-nvim-dap README for more information
				handlers = {},
				-- You'll need to check that you have the required things installed
				-- online, please don't ask me how to install them :)
				ensure_installed = {
					-- Update this to ensure that you have the debuggers for the langs you want
					"codelldb",
					"debugpy",
					"cortex-debug",
					"cpptools",
				},
			})
			-- Dap UI setup. For more information, see |:help nvim-dap-ui|
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸ <F6>",
						play = "▶ <F5>",
						step_into = "⏎ Into <F11>",
						step_over = "⏭ Over <F10>",
						step_out = "⏮ Out <S-F11>",
						step_back = "Back",
						run_last = "▶▶ Last",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})

			-- Change breakpoint icons
			vim.api.nvim_set_hl(0, "DapBreak", { fg = "#e51400" })
			vim.api.nvim_set_hl(0, "DapStop", { fg = "#ffcc00" })
			local breakpoint_icons = vim.g.have_nerd_font -- not set likely
					and {
						Breakpoint = "",
						BreakpointCondition = "",
						BreakpointRejected = "",
						LogPoint = "",
						Stopped = "",
					}
				or {
					Breakpoint = "●",
					BreakpointCondition = "⊜",
					BreakpointRejected = "⊘",
					LogPoint = "◆",
					Stopped = "⭔",
				}
			for type, icon in pairs(breakpoint_icons) do
				local tp = "Dap" .. type
				local hl = (type == "Stopped") and "DapStop" or "DapBreak"
				vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
			end

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			require("dap-python").setup()
			require("dap-cortex-debug").setup() -- requires node-js sadly
			-- WARN: this uses standard JSON, which mean trailing commas at the end
			-- of a list are an error! see ":h dap-launch.json"
		end,
	},
}

return M
