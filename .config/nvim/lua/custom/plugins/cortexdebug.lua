-- https://github.com/jedrzejboczar/nvim-dap-cortex-debug?tab=readme-ov-file

return {
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
}

-- FIX: horribly unfinished
