return {
  {
    -- https://github.com/shellRaining/hlchunk.nvim?tab=readme-ov-file
    "shellRaining/hlchunk.nvim",
    enabled = false,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      line_num = { enable = false, },
      chunk = { enable = true, duration = 0, delay = 0, },
      indent = { enable = false, },
    },
  },

}
