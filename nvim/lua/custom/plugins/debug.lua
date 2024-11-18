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
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("nvim-dap-virtual-text").setup()
			require("mason-nvim-dap").setup({
				-- Makes a best effort to setup the various debuggers with
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
					-- 'cortex-debug',
					"cpptools",
				},
			})
			-- Basic debugging keymaps, feel free to change to your liking!
			vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
			vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
			vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
			vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
			vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
			vim.keymap.set("n", "<leader>B", function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Debug: Set Breakpoint" })
			-- Dap UI setup. For more information, see |:help nvim-dap-ui|
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", current_frame = "*" },
				controls = {
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⏎",
						step_over = "⏭",
						step_out = "⏮",
						step_back = "b",
						run_last = "▶▶",
						terminate = "⏹",
						disconnect = "⏏",
					},
				},
			})
			-- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
			vim.keymap.set("n", "<F7>", dapui.toggle, { desc = "Debug: See last session result." })

			dap.listeners.after.event_initialized["dapui_config"] = dapui.open
			dap.listeners.before.event_terminated["dapui_config"] = dapui.close
			dap.listeners.before.event_exited["dapui_config"] = dapui.close

			require("dap-python").setup()
		end,
	},
	{
		"jedrzejboczar/nvim-dap-cortex-debug",
		enabled = false,
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			local dap_cortex_debug = require("dap-cortex-debug")
			local dap = require("dap")
			dap.configurations.c = {
				dap_cortex_debug.openocd_config({
					name = "Example debugging with OpenOCD",
					cwd = "${workspaceFolder}",
					executable = "${workspaceFolder}/build/${workspaceFolder}.elf",
					-- configFiles = { '${workspaceFolder}/build/openocd/connect.cfg' },
					configFiles = { "interface/stlink.cfg", "target/stm32f4x.cfg" },
					gdbTarget = "localhost:3333",
					rttConfig = dap_cortex_debug.rtt_config(0),
					showDevDebugOutput = false,
				}),
			}
		end,
	},
}

return M
