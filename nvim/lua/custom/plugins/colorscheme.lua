local schemes = {
  -- { "catppuccin/nvim",               name = "catppuccin",  lazy = true,    priority = 1000 },
  { "AlexvZyl/nordic.nvim",          lazy = true, priority = 1000 },
  { "romanaverin/charleston.nvim",   lazy = true, priority = 1000 },
  { "alexxGmZ/e-ink.nvim",           lazy = true, priority = 1000 },
  { "folke/tokyonight.nvim",         lazy = true, priority = 1000 },
  { "github-main-user/lytmode.nvim", lazy = true, priority = 1000 },
  { "mcauley-penney/techbase.nvim",  lazy = true, priority = 1000 },
  { "darianmorat/gruvdark.nvim",     lazy = true, priority = 1000 },
  { "lucasadelino/conifer.nvim",     lazy = true, priority = 1000 },
  { "santhosh-tekuri/silence.nvim",  lazy = true, priority = 1000 },
  { "webhooked/kanso.nvim",          lazy = true, priority = 1000, opts = { background = { dark = "mist" } } },
  { "eldritch-theme/eldritch.nvim",  lazy = true, priority = 1000, opts = { transparent = false } },
  { "neanias/everforest-nvim",       lazy = true, priority = 1000, opts = { background = "hard", italics = true } },
  {
    "ficcdaf/ashen.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      colors = {
        -- color stolen from sonokai shusia
        -- for no good reason it becomes transparent if temrinal bg is same as
        -- theme bg regardless of transparency option
        -- background = "#1A181A",
        background = "#211F22",
        -- background = "#2D2A2E",
      },
      transparent = false,
      style_presets = {
        -- bold_functions = true,
        italic_comments = true,
      },
      hl = {
        merge_override = {
          ["@function"] = { { bold = true } },
          ["@function.call"] = { { bold = false, italic = false } },
          ["@function.method.call"] = { { bold = false, italic = false } },
          ["@function.builtin"] = { { bold = false, italic = false } },

          -- ["@attribute"] = { nil, nil, { bold = true, italic = false } },
          -- ["@keyword"] = { { nil, nil, bold = true, italic = false } },
          -- ["@keyword.function"] = { nil, nil, { bold = true, italic = false } },
          -- ["@keyword.return"] = { { nil, nil, bold = true, italic = false } },
          -- ["@keyword.exception"] = { nil, nil, { bold = true, italic = false } },
          -- ["@keyword.repeat"] = { { nil, nil, bold = true, italic = false } },
          -- ["@keyword.operator"] = { nil, nil, { bold = true, italic = false } },
          -- ["@keyword.conditional"] = { nil, nil, { bold = true, italic = false } },
          -- ["@keyword.modifier"] = { nil, nil, { bold = true, italic = false } },
          -- ["@keyword.coroutine"] = { nil, nil, { bold = true, italic = false } },
          -- ["@keyword.type"] = { nil, nil, { bold = true, italic = false } },
        },
      },
    }
  },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      local gruvbox = require("gruvbox")
      local palette = gruvbox.palette
      gruvbox.setup({
        undercurl = true,
        underline = true,
        bold = true,
        italic = {
          strings = true,
          emphasis = true,
          comments = true,
          operators = false,
          folds = true,
        },
        strikethrough = true,
        dim_inactive = false,
        transparent_mode = false,
        overrides = {
          ["@attribute"] = { italic = true },
          ["@keyword"] = { italic = true, bold = false, fg = palette.bright_red },
          ["@keyword.function"] = { italic = true, bold = true, fg = palette.bright_red },
          ["@keyword.return"] = { italic = true, bold = true, fg = palette.bright_red },
          ["@keyword.exception"] = { italic = true, bold = true, fg = palette.bright_red },
          ["@keyword.repeat"] = { italic = true, bold = false, fg = palette.bright_red },
          ["@keyword.operator"] = { italic = true, bold = false, fg = palette.bright_red },
          ["@keyword.conditional"] = { italic = true, bold = false, fg = palette.bright_red },
          ["@keyword.modifier"] = { italic = true, fg = palette.bright_red },
          ["@keyword.coroutine"] = { italic = true, fg = palette.bright_red },
          ["@keyword.type"] = { italic = true, bold = true, fg = palette.bright_red },
        },
      })
    end,
  },
  {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_foreground = "material"
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_better_performance = 1
    end,
  },
  {
    "sainnhe/sonokai",
    lazy = true,
    priority = 1000,
    config = function()
      vim.g.sonokai_style = "shusia"
      vim.g.sonokai_enable_italic = true
      vim.g.sonokai_transparent_background = false
      vim.g.sonokai_current_word = "bold"
      vim.g.sonokai_better_performance = 1
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      commentStyle = { italic = true },
      functionStyle = {},
      keywordStyle = { italic = true },
      statementStyle = { bold = true },
      typeStyle = {},
      -- transparent = true,
      theme = "wave",    -- Load "wave" theme when 'background' option is not set
      background = {     -- map the value of 'background' option to a theme
        dark = "dragon", -- try "dragon" !
        light = "lotus",
      },
    },
  },
  {
    "olimorris/onedarkpro.nvim",
    lazy = true,
    priority = 1000, -- Ensure it loads first
    config = function()
      require("onedarkpro").setup({
        options = {
          -- transparency = true,
          lualine_transparency = true,
        },
        styles = {
          types = "italic",
          methods = "NONE",
          numbers = "NONE",
          strings = "italic",
          comments = "italic",
          keywords = "bold,italic",
          constants = "NONE",
          functions = "italic",
          operators = "NONE",
          variables = "NONE",
          parameters = "NONE",
          conditionals = "italic",
          virtual_text = "italic",
        },
      })
    end,
  },
}

------------------------------------------------------------------

-- Path to the file where the colorscheme will be saved
local colorscheme_file = vim.fn.stdpath("config") .. "/lua/custom/colorscheme.txt"

function schemes.read_colorscheme()
  local f = io.open(colorscheme_file, "r")
  if f then
    local colorscheme = f:read("*l")
    f:close()
    return colorscheme
  end
  return nil
end

local function write_colorscheme(colorscheme)
  local f = io.open(colorscheme_file, "w")
  if f then
    f:write(colorscheme)
    f:close()
  end
end

function schemes.SetColorschemeFromFile()
  local active_scheme = schemes.read_colorscheme()
  if active_scheme then
    local ok, mod = pcall(require, active_scheme)
    if ok and type(mod) == "table" then
      mod.setup()
    end
    vim.cmd("colorscheme " .. active_scheme)
  end
end

-- write on loading scheme
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    local current_scheme = vim.g.colors_name
    write_colorscheme(current_scheme)
  end,
})

return schemes
