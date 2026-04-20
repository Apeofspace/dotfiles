vim.schedule(function()
  vim.pack.add({ "https://github.com/altermo/ultimate-autopair.nvim" })
  require("ultimate-autopair").setup({
    pair_cmap = false,
    fastwarp = { -- its WARP not WRAP (ffs smh fr fr wtf ong)
      map = "<C-l>",
      rmap = "<C-h>",
    },
  })
end)
