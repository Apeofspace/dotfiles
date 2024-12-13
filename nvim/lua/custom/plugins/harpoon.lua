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

		-- basic telescope configuration
		local conf = require("telescope.config").values
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end
			require("telescope.pickers")
				.new({}, {
					prompt_title = "Harpoon",
					finder = require("telescope.finders").new_table({
						results = file_paths,
					}),
					previewer = conf.file_previewer({}),
					sorter = conf.generic_sorter({}),
				})
				:find()
		end

		--stylua: ignore start
		vim.keymap.set("n", "<leader>sH", function() toggle_telescope(harpoon:list()) end, { desc = "Harpoon telescope" })
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
