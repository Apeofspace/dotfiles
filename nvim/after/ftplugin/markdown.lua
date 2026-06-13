vim.g.maplocalleader = " "
vim.opt_local.wrap = true        -- Enable soft line wrapping
vim.opt_local.linebreak = true   -- Wrap at word boundaries, not in the middle of a word
vim.opt_local.breakindent = true -- Indent wrapped lines to align with the start of the text
vim.opt_local.conceallevel = 1

local ok_mdp, mdp = pcall(require, "markdown-plus")
if ok_mdp then
  mdp.setup({})
end
