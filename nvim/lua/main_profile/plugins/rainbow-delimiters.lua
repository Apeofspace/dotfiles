local M = {
  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    event = "VeryLazy",
    config = function()
      local rd = require("rainbow-delimiters")

      if vim.g.RAINBOW_DELIMITERS_ENABLED then
        rd.enable()
      else
        rd.disable()
      end

      -- set up a binding to toggle it
      vim.keymap.set("n", "<leader>tD", function()
        if rd.is_enabled() then
          rd.disable()
          vim.notify("Rainbow-Delimiters disabled for the buffer")
        else
          rd.enable()
          vim.notify("Rainbow-Delimiters enabled for the buffer")
        end
        vim.g.RAINBOW_DELIMITERS_ENABLED = rd.is_enabled()
      end, { desc = "Toggle rainbow delimiters for buffer" })
    end,
  },
}

return M
