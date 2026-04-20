vim.pack.add({ "https://github.com/MunsMan/kitty-navigator.nvim" })

require("kitty-navigator").setup({ keybindings = {} })

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'kitty-navigator' and kind == 'update' then
      vim.cmd("!cp navigate_kitty.py ~/.config/kitty")
      vim.cmd("!cp pass_keys.py ~/.config/kitty")
    end
  end
})
