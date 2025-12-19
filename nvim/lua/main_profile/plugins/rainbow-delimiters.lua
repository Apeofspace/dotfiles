-- for reasons unknown this doesnt work with kanso theme LOLW
-- kanso is extra weird tbh

local set_file = vim.fn.stdpath("config") .. "/lua/custom/rainbow-delimiters.txt"

return {
  "https://gitlab.com/HiPhish/rainbow-delimiters.nvim",
  event = "VeryLazy",
  config = function()
    local rd = require("rainbow-delimiters")

    -- load from a file if its toggled
    local enabled = true
    local f = io.open(set_file, "r")
    if f then
      local t = f:read("*l")
      if t then
        enabled = (t == "true")
      end
      f:close()
    end
    -- NOTE for some awful reason this only works on VeryLazy
    if enabled then
      rd.enable()
    else
      rd.disable()
    end

    -- set up a binding to toggle it
    vim.keymap.set("n", "<leader>td", function()
      if rd.is_enabled() then
        rd.disable()
        vim.notify("Rainbow-Delimiters disabled for the buffer")
      else
        rd.enable()
        vim.notify("Rainbow-Delimiters enabled for the buffer")
      end
      local f = io.open(set_file, "w")
      if f then
        f:write(tostring(rd.is_enabled()))
        f:close()
      end
    end, { desc = "Toggle rainbow delimiters for buffer" })
  end,
}
