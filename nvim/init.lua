if vim.g.neovide then
  -- cewl cursor shader
  vim.g.neovide_cursor_vfx_mode = "pixiedust"
end

require("main_profile.set")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  change_detection = {
    notify = false,
  },
  import = "main_profile.plugins",
})

-- require("main_profile.scopehighlight") -- testing
-- require("main_profile.notesync") -- testing
-- require("main_profile.cmdline") -- testing

require("langmapper").automapping({ buffer = false })
