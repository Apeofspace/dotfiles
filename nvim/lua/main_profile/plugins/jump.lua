return {
  "yorickpeterse/nvim-jump",
  config = function()
    local jump = require("jump")
    jump.setup({})
    vim.keymap.set({ 'n', 'x', 'o' }, 'S', jump.start, {})
  end
}
