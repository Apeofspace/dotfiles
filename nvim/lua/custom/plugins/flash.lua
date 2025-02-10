local M = {
	"folke/flash.nvim",
	event = "VeryLazy",
  -- enabled = false,
	---@type Flash.Config
	opts = {},
  -- stylua: ignore
  keys = {
    { "<CR>", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    -- { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  },
}

return M
