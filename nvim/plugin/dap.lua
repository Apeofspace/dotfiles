vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" }, -- dependency
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/igorlfs/nvim-dap-view",              version = vim.version.range("1.*") },
  { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" }, -- automason daps
  { src = "https://github.com/mfussenegger/nvim-dap-python" },
  { src = "https://github.com/jedrzejboczar/nvim-dap-cortex-debug" },
})

require("mason").setup({})
require("mason-nvim-dap").setup({
  automatic_installation = true,
  ensure_installed = { "python", "cortex-debug" }
}) -- weirldy this doesn't work

vim.keymap.set("n", "<leader>bb", require("dap").toggle_breakpoint, { desc = "Breakpoint toggle" })
vim.keymap.set("n", "<leader>bc", require("dap").continue, { desc = "Connect/Continue" })
vim.keymap.set("n", "<leader>bD", require("dap").terminate, { desc = "Terminate session" })
vim.keymap.set("n", "<leader>bi", require("dap").step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>bo", require("dap").step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>bO", require("dap").step_out, { desc = "Step Out" })

vim.keymap.set("n", "<leader>bt", require("dap-view").toggle, { desc = "Open/Close" })
vim.keymap.set("n", "<leader>bw", require("dap-view").add_expr, { desc = "WATCH" })
vim.keymap.set("n", "<leader>bk", require("dap-view").hover, { desc = "Hover" })
vim.keymap.set("n", "<leader>bv", require("dap-view").virtual_text_toggle, { desc = "Virtual text toggle" })

-- TODO when all of this works add DAP to mason auinstall

-- Change breakpoint icons
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
local breakpoint_icons = vim.g.have_nerd_font
    and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
    or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
for type, icon in pairs(breakpoint_icons) do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

-- Language specific
require("dap-python").setup("uv")
require('dap-cortex-debug').setup()
