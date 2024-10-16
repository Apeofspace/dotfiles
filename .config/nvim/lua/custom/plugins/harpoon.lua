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
		vim.keymap.set("n", "<leader><leader>", function() harpoon.ui:toggle_quick_menu(require("harpoon"):list()) end, { desc = "Harpoon list" })
		vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end, { desc = "Harpoon add" })
		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })
		vim.keymap.set("n", "<leader>5", function() harpoon:list():select(5) end, { desc = "Harpoon file 5" })
		vim.keymap.set("n", "<leader>6", function() harpoon:list():select(6) end, { desc = "Harpoon file 6" })
		vim.keymap.set("n", "<leader>7", function() harpoon:list():select(7) end, { desc = "Harpoon file 7" })
		vim.keymap.set("n", "<leader>8", function() harpoon:list():select(8) end, { desc = "Harpoon file 8" })
		vim.keymap.set("n", "<leader>9", function() harpoon:list():select(9) end, { desc = "Harpoon file 9" })
		--stylua: ignore end

		-- hotkeys when harpoon window is open only
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "harpoon" },
		--stylua: ignore start
			callback = function()
				vim.keymap.set("n", "1", function() harpoon:list():select(1) end, { buffer = true })
				vim.keymap.set("n", "2", function() harpoon:list():select(2) end, { buffer = true })
				vim.keymap.set("n", "3", function() harpoon:list():select(3) end, { buffer = true })
				vim.keymap.set("n", "4", function() harpoon:list():select(4) end, { buffer = true })
				vim.keymap.set("n", "5", function() harpoon:list():select(5) end, { buffer = true })
				vim.keymap.set("n", "6", function() harpoon:list():select(6) end, { buffer = true })
				vim.keymap.set("n", "7", function() harpoon:list():select(7) end, { buffer = true })
				vim.keymap.set("n", "8", function() harpoon:list():select(8) end, { buffer = true })
				vim.keymap.set("n", "9", function() harpoon:list():select(9) end, { buffer = true })
			end,
			--stylua: ignore end
		})
	end,
}
