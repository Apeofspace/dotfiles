return {
  {
    -- https://github.com/shellRaining/hlchunk.nvim?tab=readme-ov-file
    "shellRaining/hlchunk.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        line_num = {
          enable = false,
        },
        chunk = {
          -- https://github.com/shellRaining/hlchunk.nvim/blob/main/docs/en/chunk.md#chunk_example1
          enable = true,
          duration = 0,
          delay = 0,
        },
        indent = {
          enable = false,
        },
      })
    end,
  },

  {
    "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
    -- set up a binding to toggle it
    init = function()
      local rd = require("rainbow-delimiters")
      vim.keymap.set("n", "<leader>td", function()
        if rd.is_enabled() then
          rd.disable()
          vim.notify("Rainbow-Delimiters disabled for the buffer")
        else
          rd.enable()
          vim.notify("Rainbow-Delimiters enabled for the buffer")
        end
      end, { desc = "Toggle rainbow delimiters for buffer" })
    end,
  },
}
