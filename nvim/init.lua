require("options")
require("langmap_config")
require("prune_packs")

-- After much consideration I've decided to have a singular init.lua file with most config,
-- and only just a few extra files
-- all of the vim.pack.add() happens at once, setups happen below

vim.pack.add({
  -- libs
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/yorickpeterse/nvim-tree-pairs" },
  { src = 'https://github.com/nvim-mini/mini.nvim' },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },

  -- must have
  { src = "https://github.com/rmagatti/auto-session" },
  { src = "https://github.com/ficcdaf/ashen.nvim" },
  { src = "https://github.com/karb95/neoscroll.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/ThePrimeagen/harpoon",                     version = "harpoon2" },
  { src = "https://github.com/MunsMan/kitty-navigator.nvim" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/ibhagwan/fzf-lua" },

  -- completion
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/Saghen/blink.cmp",                         version = vim.version.range("*") },
  { src = "https://github.com/altermo/ultimate-autopair.nvim" },

  -- mason
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },

  -- dap
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/igorlfs/nvim-dap-view",                    version = vim.version.range("1.*") },
  { src = "https://github.com/jay-babu/mason-nvim-dap.nvim" }, -- automason daps
  { src = "https://github.com/mfussenegger/nvim-dap-python" },
  { src = "https://github.com/jedrzejboczar/nvim-dap-cortex-debug" },
  { src = "https://github.com/iilw/nui-diagnostic.nvim" },

  -- diff
  { src = "https://github.com/esmuellert/codediff.nvim" },
  { src = "https://github.com/NeogitOrg/neogit" },

  -- markdown
  { src = "https://github.com/yousefhadder/markdown-plus.nvim" },
  { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },

  -- misc
  { src = "https://github.com/chrisgrieser/nvim-early-retirement" },
  { src = "https://github.com/ruicsh/termite.nvim" },
  { src = "https://github.com/rachartier/tiny-cmdline.nvim" },
  -- { src = "https://github.com/stevearc/aerial.nvim" },

  -- AI
  -- { src = "https://github.com/yetone/avante.nvim" },
  { src = "https://github.com/olimorris/codecompanion.nvim" },

  -- langmapper
  { src = "https://github.com/Wansmer/langmapper.nvim" },
})


-- MINI
local moveopts = {
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = "<C-Left>",
    right = "<C-Right>",
    down = "<C-Down>",
    up = "<C-Up>",
    -- Move current line in Normal mode
    line_left = "<C-Left>",
    line_right = "<C-Right>",
    line_down = "<C-Down>",
    line_up = "<C-Up>",
  },
}
local hipatternsopts = {
  highlighters = {
    fixme = { pattern = "%f[%w]()FIX()%f[%W]", group = "MiniHipatternsFixme" },
    shitcode = { pattern = "%f[%w]()SHITCODE()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    crutch = { pattern = "%f[%w]()CRUTCH()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
    warn = { pattern = "%f[%w]()WARN()%f[%W]", group = "MiniHipatternsHack" },
    important = { pattern = "%f[%w]()IMPORTANT()%f[%W]", group = require("mini.hipatterns").compute_hex_color_group("#FF5C00", 'bg') },
    hex_color = require("mini.hipatterns").gen_highlighter.hex_color(),
  },
}
local miniclue = require("mini.clue")
local clueopts = {
  triggers = {
    -- These are automatic triggers
    -- Leader triggers
    { mode = "n", keys = "<Leader>" },
    { mode = "x", keys = "<Leader>" },
    -- { mode = "n", keys = "<LocalLeader>" },
    -- { mode = "x", keys = "<LocalLeader>" },
    -- Built-in completion
    { mode = "i", keys = "<C-x>" },
    -- `g` key
    { mode = "n", keys = "g" },
    -- Marks
    { mode = "n", keys = "'" },
    { mode = "n", keys = "`" },
    { mode = "x", keys = "'" },
    { mode = "x", keys = "`" },
    -- Registers
    { mode = "n", keys = '"' },
    { mode = "x", keys = '"' },
    { mode = "i", keys = "<C-r>" },
    { mode = "c", keys = "<C-r>" },
    -- `z` key
    { mode = "n", keys = "z" },
    { mode = "x", keys = "z" },
  },
  clues = {
    -- These are custom triggers that are manually added
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    miniclue.gen_clues.windows(),
    miniclue.gen_clues.z(),
    { mode = "n", keys = "<Leader>o",  desc = "Oil" },
    { mode = "n", keys = "<Leader>m",  desc = "Markdown" },
    { mode = "n", keys = "<Leader>g",  desc = "GIT" },
    { mode = "n", keys = "<Leader>gd", desc = "Git diffview" },
    { mode = "n", keys = "<Leader>s",  desc = "PICKERS" },
    { mode = "n", keys = "<Leader>t",  desc = "Toggles" },
    { mode = "n", keys = "<Leader>w",  desc = "doesnt work for some reason" },
    { mode = "n", keys = "<Leader>D",  desc = "DEBUG" },
  },
  window = {
    delay = 0,
    width = 'auto',
  },
}
local surroundopts = {
  mappings = {
    add = 'Sa',        -- Add surrounding in Normal and Visual modes
    delete = 'Sd',     -- Delete surrounding
    find = 'Sf',       -- Find surrounding (to the right)
    find_left = 'SF',  -- Find surrounding (to the left)
    highlight = 'Sh',  -- Highlight surrounding
    replace = 'Sr',    -- Replace surrounding

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
}
local aiopts = {
  n_lines = 500,
  mappings = {
    -- disable these to get way for build-in incremental selection
    around_next = '',
    inside_next = '',
    around_last = '',
    inside_last = '',
  }
}
local operatoropts = {
  exchange = { prefix = "" },
  replace = {
    prefix = 's',
    -- prefix = '<leader>r',
    -- reindent_linewise = true, -- Whether to reindent new text to match previous indent
  },
}
local commentopts = {
  options = {
    ignore_blank_line = true,
  },
}

require("mini.icons").setup({})
require("mini.ai").setup(aiopts)
require("mini.align").setup({}) -- press gA to start
require("mini.operators").setup(operatoropts)
require("mini.move").setup(moveopts)
require("mini.hipatterns").setup(hipatternsopts)
require("mini.clue").setup(clueopts)
require("mini.surround").setup(surroundopts)
require("mini.comment").setup(commentopts)
require("mini.splitjoin").setup({}) -- gS to toggle line/column for lists

require("mini.icons").mock_nvim_web_devicons()


-- COLORSCHEME
local ashen = require("ashen")
local colors = require("ashen.colors")
local ashen_opts = {
  colors = { background = "#1d1f21", blue = colors["orange_blaze"], g_0 = "#f0f0f0", g_10 = "#1d1d1c" },
  style_presets = { italic_comments = true },
  transparent = false, -- linenumber may be hard to see if you do this
  hl = {
    merge_override = {
      ["@constant"] = { "orange_smolder" },
      ["@function"] = { "g_0", { bold = true } },
      ["@function.call"] = { "g_0", { bold = true } },
      ["@function.builtin"] = { "g_0", { bold = true } },
      ["@function.method.call"] = { "g_0", { bold = true } },
      ["@string"] = { "green_light" },
      ["@operator"] = { "red_ember" },
      -- ["@operator"] = { "g_6" },
      ["@type"] = { "g_6" },
      ["@keyword.modifier"] = { "g_2" },
      ["@lsp.type.namespace"] = {},
      ["@lsp.type.property"] = { "g_4" },
      ["@constructor"] = { "orange_glow" },
      ["WinSeparator"] = { "grey" },
      ["@punctuation.delimiter"] = { "g_5" },
      -- ["@markup.raw"] = { "bg0" },
      ["@markup.list"] = { "orange_smolder" },
      ["@markup.list.checked"] = { "green_light" },
      ["@markup.list.unchecked"] = { "orange_smolder" },

    },
    link = {
      ["@boolean"] = "@constant",
      ["@number"] = "@constant",
      ["@number.float"] = "@constant",
      ["@lsp.type.class"] = "@constructor",
      ["@lsp.type.enum"] = "@lsp.type.class",
      ["@type.builtin"] = "@type",
      ["@keyword.modifier"] = "@keyword.type",
    },
  },
}
vim.opt.winborder = "rounded" -- borders for completion and hover
ashen.setup(ashen_opts)
vim.cmd.colorscheme("ashen")


-- TREESITTER
local ensure_installed_ts = {
  "bash",
  "c",
  "cmake",
  "diff",
  "go",
  "html",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "regex",
  "toml",
  "vim",
  "vimdoc",
  "yaml",
  "zig"
}

require("nvim-treesitter").install(ensure_installed_ts)
require('tree-pairs').setup()

-- it must be in a group. also this is the only way it works for some reason
local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })
vim.api.nvim_create_autocmd('FileType', {
  group = group,
  desc = "Enable TreeSitter highlighting",
  callback = function(ev)
    local ft = ev.match
    local lang = vim.treesitter.language.get_lang(ft) or ft
    local buf = ev.buf
    pcall(vim.treesitter.start, buf, lang)
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- NEOSCROLL
local running_neovide = vim.g.neovide
if running_neovide == true then
  return
end
vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/karb94/neoscroll.nvim" }
  })
  require("neoscroll").setup({
    easing = "quadratic",
    performance_mode = false, -- disable treesitter
    hide_cursor = false,
    stop_eof = false,
  }
  )
end)

-- SESSIONS
require("auto-session").setup({ suppressed_dirs = { "~/", "~/Downloads", "/" } })


-- PICKER /FZF LUA
local map = vim.keymap.set
local fzf = require("fzf-lua")
fzf.setup({
  winopts = {
    border = "rounded",
  },
  ui_select = function(fzf_opts, items)
    return vim.tbl_deep_extend("force", fzf_opts, {
      winopts = {
        width = 0.5,
        height = math.floor(math.min(vim.o.lines * 0.8, #items + 4) + 0.5),
        preview = { hidden = "hidden" },
      },
    })
  end
})

map("n", "<leader>ss", fzf.builtin, { desc = "All pickers" })
-- find files
map("n", "ff", fzf.files, { desc = "Find Files" })
map("n", "<leader>sn", function() fzf.files({ cwd = vim.fn.stdpath("config") }) end, { desc = "NVIM config" })

-- search
map("n", "<leader>/", fzf.blines, { desc = "Buffer Lines" })
map("n", "<leader>sg", fzf.live_grep, { desc = "Grep" })
map("n", "<leader>sh", fzf.help_tags, { desc = "Help Pages" })
map("n", "<leader>sr", fzf.resume, { desc = "Resume search" })
map("n", "<leader>sp", fzf.spell_suggest, { desc = "Spelling" })
map("n", "<leader>sC", fzf.grep_cword, { desc = "Grep word under cursor" })

-- LSP
map("n", "gd", fzf.lsp_definitions, { desc = "Goto Definition" })
map("n", "gD", fzf.lsp_declarations, { desc = "Goto Declaration" })
map("n", "gI", fzf.lsp_implementations, { desc = "Goto Implementation" })
map("n", "<leader>sc", fzf.lsp_references, { desc = "References" })
map("n", "<leader>sw", fzf.lsp_live_workspace_symbols, { desc = "Workspace Symbols" })
map("n", "<leader>se", fzf.diagnostics_document, { desc = "Diagnostics document" })
map("n", "<leader>sE", fzf.diagnostics_workspace, { desc = "Diagnostics workspace" })
map("n", "<leader><leader>", function()
  fzf.lsp_document_symbols({ winopts = { height = 0.5, width = 0.3, preview = { hidden = "hidden" } } })
end, { desc = "LSP Symbols (file)" })


-- OIL
require("oil").setup({
  delete_to_trash = true,
  view_options = { show_hidden = true },
  keymaps = { ["q"] = { "actions.close", mode = "n" }, },
})
vim.keymap.set("n", "<leader>oi", function() require("oil").open() end, { desc = "[O]il" })


-- HARPOON
vim.schedule(function()
  vim.pack.add({
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/ThePrimeagen/harpoon", version = "harpoon2" }
  })
  local harpoon = require("harpoon")
  harpoon:setup()

  vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
    { desc = "Harpoon list" })
  vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
  vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end, { desc = "Harpoon 1" })
  vim.keymap.set("n", "<M-s>", function() harpoon:list():select(2) end, { desc = "Harpoon 2" })
  vim.keymap.set("n", "<M-d>", function() harpoon:list():select(3) end, { desc = "Harpoon 3" })
  vim.keymap.set("n", "<M-f>", function() harpoon:list():select(4) end, { desc = "Harpoon 4" })
  vim.keymap.set("n", "<M-g>", function() harpoon:list():select(5) end, { desc = "Harpoon 5" })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "harpoon" },
    callback = function()
      for i = 1, 9 do
        vim.keymap.set("n", tostring(i), function() harpoon:list():select(i) end, { buffer = true })
      end
    end,
  })
end)


-- KITTY-NAV INTEGRATION
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


-- STATUSLINE / LUALINE
local get_linecount = function()
  -- return vim.fn.line("$") .. " lines" or ""
  local totallines = vim.fn.line("$")
  local thisline   = string.format("%" .. #tostring(totallines) .. "s", vim.fn.line(".")) -- right-aligned padded to #totallines
  local col        = string.format("%-3s", vim.fn.col("."))                               -- left-aligned padded to 3
  return thisline .. "/" .. totallines .. ":" .. col
end
local section_config = {
  -- +-------------------------------------------------+
  -- | A | B | C                             X | Y | Z |
  -- +-------------------------------------------------+
  lualine_a = { "mode" },
  lualine_b = { "branch", "filename" },
  lualine_c = { "diagnostics" },
  lualine_x = { "lsp_status", "encoding", "filetype" },
  lualine_y = {},
  lualine_z = { get_linecount },
}
local tabline_config = {
  lualine_a = { { "tabs", mode = 2 } },
}
require("lualine").setup({
  options = {
    -- globalstatus = true, -- uncomment for single bar
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },                                  -- single bar unfortunately only works for bottom statusbar and not winbar
  sections = section_config,
  inactive_sections = section_config, -- comment out for single bar
  -- winbar = { lualine_c = { "filename" } },
  -- inactive_winbar = { lualine_c = { "filename" } },
  tabline = tabline_config,
})
vim.schedule(function()
  -- lualine overrites showtabline to 2. Manually reset to 1 AFTER it loads
  vim.opt.showtabline = 1
end)


-- COMPLETION / BLINK
local blinkopts = {
  keymap = {
    ["<CR>"] = {
      function(cmp) -- accept THEN show signature
        local accepted = cmp.accept()
        if accepted then
          cmp.show_signature()
        end
        return accepted
      end,
      "fallback",
    },
  },
  signature = { enabled = true, window = { show_documentation = false } },
}
require("blink.cmp").setup(blinkopts)

-- AUTOPAIR
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

-- LSP
require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "clangd",
    "ty",
    "ruff",
    "zls"
  }
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("cool-lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    -- MAPPINGS
    local map_lsp = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end
    map_lsp("K", vim.lsp.buf.hover, "Hover Documentation")

    if client:supports_method("textDocument/inlayHint") then
      map_lsp("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        if vim.lsp.inlay_hint.is_enabled() == true then
          vim.notify("Inlay hints enabled")
        else
          vim.notify("Inlay hints disabled")
        end
      end, "[T]oggle Inlay [H]ints")
    end

    if client:supports_method("textDocument/codeLens") then
      map_lsp("<leader>tl", function()
        vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled())
        if vim.lsp.codelens.is_enabled() == true then
          vim.notify("CodeLens enabled")
        else
          vim.notify("CodeLens disabled")
        end
      end, "[T]oggle Code[L]ens")
    end

    -- format with LSP
    if client.server_capabilities.documentFormattingProvider then
      map_lsp("<leader>f", vim.lsp.buf.format, "Format with LSP")
    end
    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    -- if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
    if client and client.server_capabilities.documentHighlightProvider then
      local hl_gr = vim.api.nvim_create_augroup('bold_hl_group', { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = hl_gr,
        callback = vim.lsp.buf.document_highlight,
        -- this requires some highlights to be defined check :h document_highlight
      })
      -- When you move your cursor, the highlights will be cleared
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = hl_gr,
        callback = vim.lsp.buf.clear_references,
      })
      -- remove autocmd when detached
      vim.api.nvim_create_autocmd('LspDetach', {
        group = hl_gr,
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'bold_hl_group', buffer = event2.buf }
        end,
      })
    end
    vim.opt_local.fo:remove({ "r", "o" }) -- make comments not continue on newline
    -- this is here because some LSPs overwrite it
  end,
})


-- DIAGNOSTICS
require("nui-diagnostic").setup({})
vim.keymap.set("n", "<leader>e", require("nui-diagnostic").open, { desc = "Show diagnostic [E]rror messages" })


-- DEBUGGING / DAP
require("mason-nvim-dap").setup({
  automatic_installation = true,
  ensure_installed = { "python", "cortex-debug" }
})

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


-- DIFF / GIT
local neogit = require("neogit")
neogit.setup({})
vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "NEOGIT" })

local codediff = require("codediff")
codediff.setup({ explorer = { view_mode = "tree" } })
vim.keymap.set("n", "<Leader>gdo", "<cmd>CodeDiff<CR>", { desc = "Current changes" })
vim.keymap.set("n", "<Leader>gdh", "<cmd>CodeDiff history <CR>", { desc = "Commits history" })
vim.keymap.set("n", "<Leader>gdf", "<cmd>CodeDiff history %<CR>", { desc = "THIS Files History" })

-- MARKDOWN / render-markdown
require("render-markdown").setup({
  restart_highlighter = false,
  completions = { lsp = { enabled = true } },
  bullet = { left_pad = 1, right_pad = 1, icons = { '◆', '◇' } },
  file_types = { "markdown", "codecompanion" },
})

-- MISC / early retirement termite aerial
require("early-retirement").setup({})
require("termite").setup({})
-- require("aerial").setup({
--   attach_mode = "global",
--   layout = { placement = "edge", default_direction = "prefer_left" },
--   autojump = false, -- jump when cursor moves (nice with flash) default: false
--   on_attach = function(bufnr)
--     vim.keymap.set("n", "<leader><Up>", "<cmd>AerialPrev<CR>", { buffer = bufnr, desc = "Aerial UP" })
--     vim.keymap.set("n", "<leader><Down>", "<cmd>AerialNext<CR>", { buffer = bufnr, desc = "Aerial DOWN" })
--   end,
-- })
-- vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Aerial open" })

-- UI2 stuff
require('vim._core.ui2').enable({})
vim.o.cmdheight = 0
vim.pack.add({ "https://github.com/rachartier/tiny-cmdline.nvim" })
require("tiny-cmdline").setup({
  position = { y = "10%" }
})

-- AVANTE / AI

-- -- build step for avante
-- vim.api.nvim_create_autocmd("PackChanged", {
--   callback = function(ev)
--     local name, kind = ev.data.spec.name, ev.data.kind
--     vim.notify(name .. " " .. kind)
--     if name == "avante.nvim" and (kind == "install" or kind == "update") then
--       if not ev.data.active then vim.cmd.packadd("avante.nvim") end
--       vim.system({ 'make' }, { cwd = ev.data.path }):wait()
--     end
--   end
-- })
-- vim.schedule(function()
--   local avante = require("avante")
--   avante.setup({
--     selector = {
--       --- @alias avante.SelectorProvider "native" | "fzf_lua" | "mini_pick" | "snacks" | "telescope" | fun(selector: avante.ui.Selector): nil
--       --- @type avante.SelectorProvider
--       provider = "fzf_lua",
--       provider_opts = {},
--     },
--     instructions_file = "avante.md",
--     provider = "ollama",
--     providers = {
--       ollama = {
--         endpoint = "http://127.0.0.1:11434",
--         model = "qwen2.5-coder:7b",
--         extra_request_body = { options = { num_ctx = 32768, }, },
--         -- model = "qwen2.5-coder:14b",
--         -- extra_request_body = { options = { num_ctx = 8196, }, },
--         is_env_set = require("avante.providers.ollama").check_endpoint_alive,
--       },
--     },
--   })
-- end)

-- CODECOMPANION / AI
local q2514 = { adapter = "ollama", model = "qwen2.5-coder:14b", }
local q257 = { adapter = "ollama", model = "qwen2.5-coder:7b", }
local q35weird = { adapter = "ollama", model = "Qwen3.5-35B-A3B-UD-Q4_K_XL:latest", }

require("codecompanion").setup({
  opts = { log_level = "DEBUG" },
  interactions = {
    chat = q35weird,
    inline = q35weird,
    cmd = q35weird,
    background = q35weird,
  },
  rules = {
    default = {
      files = {
        "AGENT.md"
      }
    }
  }
})

vim.api.nvim_set_keymap('n', '<leader>a', '<cmd>CodeCompanionChat Toggle<cr>', { desc = "Open AI chat" })
vim.api.nvim_set_keymap('v', '<leader>a', '<cmd>CodeCompanionChat Add<cr>', { desc = "Add selection to AI chat" })
vim.api.nvim_set_keymap('n', 'grA', '<cmd>CodeCompanionActions<CR>', { desc = "AI code actions" })

-- LANGMAPPER should be last
require("langmapper").setup({})
require("langmapper").automapping({ buffer = false })
