return {
  {
    'johnpmitsch/vai.nvim',
    -- enabled = false,
    opts = {
      trigger = 's'
    },
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    enabled = false,
    ---@type Flash.Config
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      -- { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      -- { "S",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      -- { "S",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      -- { "S", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  }
}
