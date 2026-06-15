vim.api.nvim_create_user_command("PrunePacks",
  function()
    local inactive = vim.iter(vim.pack.get())
        :filter(function(x) return not x.active end)
        :map(function(x) return x.spec.name end)
        :totable()

    if #inactive == 0 then
      vim.notify("No inactive plugins", vim.log.levels.INFO)
      return
    end

    local prompt = string.format("Delete %d inactive plugin(s)?\n%s", #inactive, table.concat(inactive, "\n"))
    local choice = vim.fn.input(prompt .. " (y/n): ")

    if choice:lower() ~= "y" then
      vim.notify("Prune cancelled.", vim.log.levels.WARN)
      return
    end

    for _, plugin in ipairs(inactive) do
      local ok, err = pcall(vim.pack.del, { plugin })
      if not ok then
        vim.notify("Failed to prune " .. plugin .. "\n" .. (err or ""), vim.log.levels.ERROR)
      else
        vim.notify("Successfully pruned: " .. plugin, vim.log.levels.INFO)
      end
    end

    vim.notify("All inactive plugins have been pruned.", vim.log.levels.INFO)
  end, {
    desc = "Prune all inactive vim.pack plugins",
    nargs = 0,
  })
