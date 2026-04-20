vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.pack.add({ "https://github.com/rmagatti/auto-session" })
require("auto-session").setup({ suppressed_dirs = { "~/", "~/Downloads", "/" } })
