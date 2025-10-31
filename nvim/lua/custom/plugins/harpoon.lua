-- I have a seriously big idea here. (not stolen from prowl at all)
-- What if instead of leader I just use some other leader key lmao like ;
-- But then the problem is that I add files numerically...USE PROWL instead!
-- okay prowl sucks because it works with open buffers of which i have too many

return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  enabled = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "VeryLazy",
  config = function()
    local harpoon = require("harpoon")
    -- REQUIRED
    harpoon:setup()
    -- REQUIRED

    --stylua: ignore start
    vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(require("harpoon"):list()) end,
      { desc = "Harpoon list" })
    vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
    -- for i = 1, 9 do
    --   vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon file " .. i })
    --   -- these Ctrl mappings are added to compensate corne being ligma
    --   vim.keymap.set("n", "<C-" .. i .. ">", function() harpoon:list():select(i) end,
    --     { desc = "Harpoon file + Ligma " .. i })
    -- end
    --stylua: ignore end
    vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<M-s>", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<M-d>", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<M-f>", function() harpoon:list():select(4) end)

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
