return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(require("harpoon"):list()) end,
        { desc = "Harpoon list" })
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
      vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<M-s>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<M-d>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<M-f>", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<M-g>", function() harpoon:list():select(5) end)
      -- hotkeys when harpoon window is open only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "harpoon" },
        callback = function()
          for i = 1, 9 do
            vim.keymap.set("n", tostring(i), function() harpoon:list():select(i) end, { buffer = true })
          end
        end,
      })
    end,
  },
}
