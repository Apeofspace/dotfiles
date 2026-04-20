vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" }
  })
  local harpoon = require("harpoon")
  harpoon:setup()

  vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Harpoon list" })
  vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
  vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
  vim.keymap.set("n", "<M-s>", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
  vim.keymap.set("n", "<M-d>", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
  vim.keymap.set("n", "<M-f>", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
  vim.keymap.set("n", "<M-g>", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "harpoon" },
    callback = function()
      for i = 1, 9 do
        vim.keymap.set("n", tostring(i), function() harpoon:list():select(i) end, { buffer = true })
      end
    end,
  })
end)
