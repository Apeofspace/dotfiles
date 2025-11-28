local schemes = {
  { "AlexvZyl/nordic.nvim",         lazy = true, priority = 1000 },
  { "folke/tokyonight.nvim",        lazy = true, priority = 1000 },
  { "webhooked/kanso.nvim",         lazy = true, priority = 1000, opts = { background = { dark = "mist" } } },
  { "alexxGmZ/e-ink.nvim",          lazy = true, priority = 1000, },
  { "EdenEast/nightfox.nvim",       lazy = true, priority = 1000, opts = { options = { styles = { comments = "italic", strings = "italic" } } } },
  { "zenbones-theme/zenbones.nvim", lazy = true, priority = 1000, dependencies = { "rktjmp/lush.nvim" } }, -- less clown version of other themes
  { "adibhanna/yukinord.nvim",      lazy = true, priority = 1000, },
  {
    "Kaikacy/Lemons.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd("ColorScheme", {
        -- this to ensure I change highlight after it loads
        pattern = "*",
        once = true, -- the config is only called the first time =(
        callback = function()
          vim.api.nvim_set_hl(0, "Visual", { bg = "#3a3d41" })
          vim.api.nvim_set_hl(0, "WinSeparator", { fg = "#3a3d41" })
          -- neogit colors
          vim.api.nvim_set_hl(0, "NeogitDiffDelete", { fg = "#e74c3c" })
          vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { fg = "#e74c3c" })
          vim.api.nvim_set_hl(0, "NeogitDiffDeleteCursor", { fg = "#e74c3c" })
        end,
      })
      local opts = {
        undercurl = true,
        colors_override = {
          black = "#1d1f21",
          white = "#e5e5e5"
        }
      }
      require("lemons").setup(opts)
      --   require("lemons.colors")["black"] = "#1d1f21" -- olde more universal way to do that
      --   require("lemons.colors")["white"] = "#e5e5e5" -- less bright white
    end
  },
  { "nyoom-engineering/oxocarbon.nvim", lazy = true, priority = 1000 },
  { "slugbyte/lackluster.nvim",         lazy = true, priority = 1000 },
  { "armannikoyan/rusty",               lazy = true, priority = 1000 }, -- super nice actually
  {
    "neanias/everforest-nvim",
    lazy = true,
    priority = 1000,
    config = function() -- this themes likes config rather than opts for some reason
      local everforest = require("everforest")
      everforest.setup({
        background = "hard",
        italics = true,
        on_highlights = function(hl, palette)
          hl.TSString = { fg = palette.aqua, italic = true } -- default
          hl.TSPunctBracket = { fg = "#96938a" }             -- slightly more mellow
        end,
      })
    end
  },
  {
    "ficcdaf/ashen.nvim",
    -- no matter what I do it just sucks. some color is always off and merging barely works
    lazy = true,
    priority = 1000,
    opts = {
      -- colors = { background = "#2D2A2E" }, -- color stolen from sonokai shusia
      colors = { background = "#1d1f21" }, -- color stolen from rusty colorscheme and I love it
      style_presets = { italic_comments = true },
      hl = {
        merge_override = {
          ["@function"] = { { bold = true } },
          ["@function.call"] = { { bold = false, italic = false } },
          ["@function.method.call"] = { { bold = false, italic = false } },
          ["@function.builtin"] = { { bold = false, italic = false } },
          ["@string"] = { "red_glowing", nil, { italic = true } },
          ["WinSeparator"] = { "grey", nil, nil },
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
