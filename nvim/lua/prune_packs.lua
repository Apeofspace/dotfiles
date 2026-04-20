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

    vim.ui.select(inactive, {
      prompt = string.format("Delete %d inactive plugin(s)?", #inactive),
      format_item = function(item)
        return item
      end,
    }, function(choice)
      if not choice then
        vim.notify("Prune cancelled.", vim.log.levels.WARN)
        return
      end

      local ok, err = pcall(vim.pack.del, { choice })
      if ok then
        vim.notify("Successfully pruned: " .. choice, vim.log.levels.INFO)
      else
        vim.notify("Failed to prune " .. choice .. "\n" .. (err or ""), vim.log.levels.ERROR)
      end
    end)
  end, {
    desc = "Prune inactive vim.pack plugins",
    nargs = 0,
  })
