return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	enabled = true,
	dependencies = { "nvim-lua/plenary.nvim" },
	event = "VeryLazy",
	-- lazy = false,
	config = function()
		local harpoon = require("harpoon")
		-- REQUIRED
		harpoon:setup()
		-- REQUIRED

		--stylua: ignore start
		vim.keymap.set("n", "<leader>H", function() harpoon.ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = "Harpoon list" })
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
		for i = 1,9 do
			vim.keymap.set("n", "<leader>"..i, function() harpoon:list():select(i) end, { desc = "Harpoon file "..i })
		end
		--stylua: ignore end

		-- hotkeys when harpoon window is open only
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "harpoon" },
			callback = function()
				for i = 1, 9 do
					--stylua: ignore start
						vim.keymap.set("n", tostring(i), function() harpoon:list():select(i) end, { buffer = true })
					--stylua: ignore end
				end
			end,
		})
	end,
}
