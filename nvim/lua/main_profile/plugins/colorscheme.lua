local schemes = {
  { "AlexvZyl/nordic.nvim",         lazy = true, priority = 1000 },
  { "folke/tokyonight.nvim",        lazy = true, priority = 1000 },
  { "webhooked/kanso.nvim",         lazy = true, priority = 1000, opts = { background = { dark = "mist" } } },
  { "alexxGmZ/e-ink.nvim",          lazy = true, priority = 1000, },
  { "EdenEast/nightfox.nvim",       lazy = true, priority = 1000, opts = { options = { styles = { comments = "italic", strings = "italic" } } } },
  -- { "zenbones-theme/zenbones.nvim", lazy = true, priority = 1000, dependencies = { "rktjmp/lush.nvim" } }, -- less clown version of other themes
  { "adibhanna/yukinord.nvim",      lazy = true, priority = 1000, },
  { "nendix/zen.nvim",              lazy = true, priority = 1000, },
  { "tommarien/github-plus.nvim",   lazy = true, priority = 1000, },
  {
    "Kaikacy/Lemons.nvim",
    lazy = true,
    priority = 1000,
    config = function()
      vim.api.nvim_create_autocmd("colorscheme", {
        -- this to ensure i change highlight after it loads
        pattern = "*",
        once = true, -- the config is only called the first time =(
        callback = function()
          -- neogit colors
          vim.api.nvim_set_hl(0, "neogitdiffdelete", { fg = "#e74c3c" })
          vim.api.nvim_set_hl(0, "neogitdiffdeletehighlight", { fg = "#e74c3c" })
          vim.api.nvim_set_hl(0, "neogitdiffdeletecursor", { fg = "#e74c3c" })
          -- document highlight
          vim.api.nvim_set_hl(0, "lspreferencetext", { bold = true })
          vim.api.nvim_set_hl(0, "lspreferenceread", { bold = true })
          vim.api.nvim_set_hl(0, "lspreferencewrite", { bold = true })
        end,
      })
      local opts = {
        undercurl = true,
        colors_override = {
          black = "#1d1f21",
          white = "#e5e5e5",
          gray = "#3a3d41",
          darkgray = "#303030",
        }
      }
      require("lemons").setup(opts)
    end
  },
  { "alexpasmantier/hubbamax.nvim",     lazy = true, priority = 1000 },
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
      -- vim.g.sonokai_style = "shusia"
      vim.g.sonokai_enable_italic = true
      -- vim.g.sonokai_colors_override = {'bg0': ['#1e222a', '235'], 'bg2': ['#282c34', '236']}
      vim.g.sonokai_transparent_background = false
      vim.g.sonokai_current_word = "bold"
      vim.g.sonokai_better_performance = 1
    end,
  },
}

------------------------------------------------------------------

local function get_user_schemes()
  local vimruntime = vim.env.VIMRUNTIME
  local seen = {}
  local schemes = {}

  for _, name in ipairs(vim.fn.getcompletion("", "color")) do
    local files = vim.api.nvim_get_runtime_file("colors/" .. name .. ".*", false)

    local path = files[1]

    -- this is supposed to filter out the default ones
    -- which is a great idea.
    if not vim.startswith(path, vimruntime) and not seen[name] then
      seen[name] = true
      table.insert(schemes, name)
    end
  end

  table.sort(schemes)
  return schemes
end

-- this is kinda stolen from telescope. it doesnt work yet and you need to apply filtering from above to it
local function get_user_schemes2()
  local colors = opts.colors or { before_color }
  if not vim.tbl_contains(colors, before_color) then
    table.insert(colors, 1, before_color)
  end

  colors = vim.list_extend(
    colors,
    vim.tbl_filter(function(color)
      return not vim.tbl_contains(colors, color)
    end, vim.fn.getcompletion("", "color"))
  )
  local lazy = package.loaded["lazy.core.util"]
  if lazy and lazy.get_unloaded_rtp then
    local paths = lazy.get_unloaded_rtp ""
    local all_files = vim.fn.globpath(table.concat(paths, ","), "colors/*", 1, 1)
    for _, f in ipairs(all_files) do
      local color = vim.fn.fnamemodify(f, ":t:r")
      if not vim.tbl_contains(colors, color) then
        table.insert(colors, color)
      end
    end
  end
  return colors
end

local function snacks_theme_picker()
  local ok, Snacks = pcall(require, "snacks")
  if not ok then
    return
  end
  -- local schemes = get_all_schemes()
  -- local schemes = get_user_schemes2()
  -- local items = vim.tbl_map(function(s) return { text = s } end, schemes) -- these needs to be tables, duh
  local items = get_user_schemes2()
  Snacks.picker.pick({
    items = items,
    title = "Colorschemes, ayyy",
    format = "text",
    preview = "colorscheme",
    preset = "vertical",
    confirm = function(picker, item)
      if item then
        picker.preview.state.colorscheme = nil
        vim.schedule(function()
          vim.cmd("colorscheme " .. item.text)
        end)
      end
      picker:close()
    end,
  })
end

vim.keymap.set("n", "<leader>sC", snacks_theme_picker, { desc = "my cewl pickar" })


-- autoload from shada on requiring this file
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  nested = true,
  callback = function()
    if vim.g.COLOR_OF_MY_PANTS then
      vim.cmd('colorscheme ' .. vim.g.COLOR_OF_MY_PANTS)
    end
  end,
})

-- autosave to shada on changing the scheme
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.g.COLOR_OF_MY_PANTS = vim.g.colors_name
  end
})

return schemes
