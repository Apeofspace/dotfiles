local schemes = {
  { "AlexvZyl/nordic.nvim",   lazy = true, priority = 1000 },
  { "folke/tokyonight.nvim",  lazy = true, priority = 1000 },
  { "webhooked/kanso.nvim",   lazy = true, priority = 1000, opts = { background = { dark = "mist" } } },
  { "alexxGmZ/e-ink.nvim",    lazy = true, priority = 1000, },
  { "EdenEast/nightfox.nvim", lazy = true, priority = 1000, opts = { options = { styles = { comments = "italic", strings = "italic" } } } },
  {
    "neanias/everforest-nvim",
    lazy = true,
    priority = 1000,
    -- opts = {},
    config = function() -- this themes likes config rather than opts for some reason
      local everforest = require("everforest")
      everforest.setup({
        -- background = "hard",
        italics = true,
        on_highlights = function(hl, palette)
          hl.TSString = { fg = palette.aqua, italic = true } -- default
          -- hl.TSString = { fg = "#a9bda2", italic = true }
          -- hl.TSVariable = { fg = "#c9bc9f" }
          hl.TSPunctBracket = { fg = "#96938a" } -- slightly more mellow
        end,
      })
    end
    -- as I understand it pickes up LSP color first and then falls back to treesitter
    -- should make my own color fg1 that is slightly more grey and fg2 that
    -- is even more so and override some highlights such as @variable @function.call @punctuation.bracket
    -- local base_palette = {
    --   light = {
    --     fg = "#5c6a72",
    --     red = "#f85552",
    --     orange = "#f57d26",
    --     yellow = "#dfa000",
    --     green = "#8da101",
    --     aqua = "#35a77c",
    --     blue = "#3a94c5",
    --     purple = "#df69ba",
    --     grey0 = "#a6b0a0",
    --     grey1 = "#939f91",
    --     grey2 = "#829181",
    --     statusline1 = "#93b259",
    --     statusline2 = "#708089",
    --     statusline3 = "#e66868",
    --     none = "NONE",
    --   },
    --   dark = {
    --     fg = "#d3c6aa",
    --     red = "#e67e80",
    --     orange = "#e69875",
    --     yellow = "#dbbc7f",
    --     green = "#a7c080",
    --     aqua = "#83c092",
    --     blue = "#7fbbb3",
    --     purple = "#d699b6",
    --     grey0 = "#7a8478",
    --     grey1 = "#859289",
    --     grey2 = "#9da9a0",
    --     statusline1 = "#a7c080",
    --     statusline2 = "#d3c6aa",
    --     statusline3 = "#e67e80",
    --     none = "NONE",
    --   },
  },
  {
    "ficcdaf/ashen.nvim",
    lazy = true,
    priority = 1000,
    opts = {
      colors = { background = "#2D2A2E" }, -- color stolen from sonokai shusia
      -- transparent = true,
      style_presets = { italic_comments = true },
      hl = {
        merge_override = {
          ["@function"] = { { bold = true } },
          ["@function.call"] = { { bold = false, italic = false } },
          ["@function.method.call"] = { { bold = false, italic = false } },
          ["@function.builtin"] = { { bold = false, italic = false } },
          ["@string"] = { "red_glowing", nil, { italic = true } },
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
