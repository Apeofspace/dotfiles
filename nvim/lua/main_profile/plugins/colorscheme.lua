return {
  "ficcdaf/ashen.nvim",
  priority = 1000,
  config = function()
    local ashen = require("ashen")
    local colors = require("ashen.colors")
    local opts = {
      colors = { background = "#1d1f21", blue = colors["orange_blaze"], g_0 = "#f0f0f0", g_10 = "#1d1d1c" },
      style_presets = { italic_comments = true },
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
          ["RenderMarkdownChecked"] = { "green_light" },
          ["RenderMarkdownCodeInline"] = { "orange_glow" },
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
    -- ashen.setup({})
    ashen.setup(opts)
    ashen.load()
  end,
}


-- local schemes = {
--   { "AlexvZyl/nordic.nvim",                         lazy = true, priority = 1000 },
--   { "alexxGmZ/e-ink.nvim",                          lazy = true, priority = 1000, },
--   { "adibhanna/yukinord.nvim",                      lazy = true, priority = 1000, },
--   { "tommarien/github-plus.nvim",                   lazy = true, priority = 1000, },
--   { "serhez/teide.nvim",                            lazy = true, priority = 1000, },                                  -- i really lke the red and the green form here but not the blue
--   { "https://gitlab.com/motaz-shokry/gruvbox.nvim", lazy = true, priority = 1000 },
--   { "connormxfadden/petrolnoir.nvim",               lazy = true, priority = 1000, config = { transparent = false } }, -- cant see shit on a sunny day
--   {
--     "oskarnurm/koda.nvim",
--     lazy = true,
--     priority = 1000,
--     opts = {
--       -- on_highlights = function(hl, c)
--       --   hl.DiagnosticUnderlineError = { fg = c.danger, underline = false, undercurl = true }
--       -- end,
--       -- transparent = true,
--       -- colors = { border = "#444444", bg = "#202020", dim = "#101010", fg = "#c0c0c0", line = "#373737" }
--       colors = { border = "#444444" }
--     }
--   },
--   {
--     "Kaikacy/Lemons.nvim",
--     lazy = true,
--     priority = 1000,
--     config = function()
--       vim.api.nvim_create_autocmd("colorscheme", {
--         -- this to ensure i change highlight after it loads
--         pattern = "*",
--         once = true, -- the config is only called the first time =(
--         callback = function()
--           local c = require("lemons.colors").colors
--           -- neogit colors
--           vim.api.nvim_set_hl(0, "neogitdiffdelete", { fg = "#e74c3c" })
--           vim.api.nvim_set_hl(0, "neogitdiffdeletehighlight", { fg = "#e74c3c" })
--           vim.api.nvim_set_hl(0, "neogitdiffdeletecursor", { fg = "#e74c3c" })
--           -- document highlight
--           -- vim.api.nvim_set_hl(0, "lspreferencetext", { bold = true })
--           -- vim.api.nvim_set_hl(0, "lspreferenceread", { bold = true })
--           -- vim.api.nvim_set_hl(0, "lspreferencewrite", { bold = true })
--           vim.api.nvim_set_hl(0, "lspreferencetext", { bg = c.gray })
--           vim.api.nvim_set_hl(0, "lspreferenceread", { bg = c.gray })
--           vim.api.nvim_set_hl(0, "lspreferencewrite", { bg = c.gray })
--           -- markdown code block
--           vim.api.nvim_set_hl(0, "markdownCode", { italic = true })
--           vim.api.nvim_set_hl(0, "markdownCodeBlock", { fg = c.lime })
--           vim.api.nvim_set_hl(0, "markdownCodeDelimiter", { fg = c.lime })
--         end,
--       })
--       local opts = {
--         undercurl = true,
--         colors_override = {
--           black = "#1d1f21",
--           white = "#e5e5e5",
--           gray = "#3a3d41",
--           darkgray = "#303030",
--         }
--       }
--       require("lemons").setup(opts)
--     end
--   },
--   {
--     "neanias/everforest-nvim",
--     lazy = true,
--     priority = 1000,
--     config = function() -- this themes likes config rather than opts for some reason
--       local everforest = require("everforest")
--       everforest.setup({
--         background = "hard",
--         italics = true,
--         on_highlights = function(hl, palette)
--           hl.TSString = { fg = palette.aqua, italic = true } -- default
--           hl.TSPunctBracket = { fg = "#96938a" }             -- slightly more mellow
--         end,
--       })
--     end
--   },
--   {
--     "ficcdaf/ashen.nvim",
--     lazy = true,
--     priority = 1000,
--     config = function()
--       local ashen = require("ashen")
--       local colors = require("ashen.colors")
--       local opts = {
--         colors = { background = "#1d1f21", blue = colors["orange_blaze"], g_0 = "#f0f0f0", g_10 = "#1d1d1c" },
--         style_presets = { italic_comments = true },
--         hl = {
--           merge_override = {
--             ["@constant"] = { "orange_smolder" },
--             ["@function"] = { "g_0", { bold = true } },
--             ["@function.call"] = { "g_0", { bold = true } },
--             ["@function.builtin"] = { "g_0", { bold = true } },
--             ["@function.method.call"] = { "g_0", { bold = true } },
--             ["@string"] = { "green_light" },
--             ["@operator"] = { "red_ember" },
--             -- ["@operator"] = { "g_6" },
--             ["@type"] = { "g_6" },
--             ["@keyword.modifier"] = { "g_2" },
--             ["@lsp.type.namespace"] = {},
--             ["@lsp.type.property"] = { "g_4" },
--             ["@constructor"] = { "orange_glow" },
--             ["WinSeparator"] = { "grey" },
--             ["@punctuation.delimiter"] = { "g_5" },
--             -- ["@markup.raw"] = { "bg0" },
--             ["RenderMarkdownChecked"] = { "green_light" },
--             ["RenderMarkdownCodeInline"] = { "orange_glow" },
--           },
--           link = {
--             ["@boolean"] = "@constant",
--             ["@number"] = "@constant",
--             ["@number.float"] = "@constant",
--             ["@lsp.type.class"] = "@constructor",
--             ["@lsp.type.enum"] = "@lsp.type.class",
--             ["@type.builtin"] = "@type",
--             ["@keyword.modifier"] = "@keyword.type",
--           },
--         },
--       }
--       -- ashen.setup({})
--       ashen.setup(opts)
--     end,
--   },
--   {
--     "sainnhe/gruvbox-material",
--     lazy = true,
--     priority = 1000,
--     config = function()
--       vim.g.gruvbox_material_enable_italic = 1
--       vim.g.gruvbox_material_background = "medium"
--       vim.g.gruvbox_material_foreground = "material"
--       vim.g.gruvbox_material_enable_bold = 1
--       vim.g.gruvbox_material_enable_bold = 1
--       vim.g.gruvbox_material_better_performance = 1
--     end,
--   },
--   {
--     "sainnhe/sonokai",
--     lazy = true,
--     priority = 1000,
--     config = function()
--       -- vim.g.sonokai_style = "shusia"
--       vim.g.sonokai_enable_italic = true
--       -- vim.g.sonokai_colors_override = {'bg0': ['#1e222a', '235'], 'bg2': ['#282c34', '236']}
--       vim.g.sonokai_transparent_background = false
--       vim.g.sonokai_current_word = "bold"
--       vim.g.sonokai_better_performance = 1
--     end,
--   },
-- }

-- ------------------------------------------------------------------

-- local function get_user_schemes()
--   local vimruntime = vim.env.VIMRUNTIME
--   local seen = {}
--   local schemes = {}

--   for _, name in ipairs(vim.fn.getcompletion("", "color")) do
--     local files = vim.api.nvim_get_runtime_file("colors/" .. name .. ".*", false)

--     local path = files[1]

--     -- this is supposed to filter out the default ones
--     -- which is a great idea.
--     if not vim.startswith(path, vimruntime) and not seen[name] then
--       seen[name] = true
--       table.insert(schemes, name)
--     end
--   end

--   table.sort(schemes)
--   return schemes
-- end

-- -- this is kinda stolen from telescope. it doesnt work yet and you need to apply filtering from above to it
-- local function get_user_schemes2()
--   local colors = opts.colors or { before_color }
--   if not vim.tbl_contains(colors, before_color) then
--     table.insert(colors, 1, before_color)
--   end

--   colors = vim.list_extend(
--     colors,
--     vim.tbl_filter(function(color)
--       return not vim.tbl_contains(colors, color)
--     end, vim.fn.getcompletion("", "color"))
--   )
--   local lazy = package.loaded["lazy.core.util"]
--   if lazy and lazy.get_unloaded_rtp then
--     local paths = lazy.get_unloaded_rtp ""
--     local all_files = vim.fn.globpath(table.concat(paths, ","), "colors/*", 1, 1)
--     for _, f in ipairs(all_files) do
--       local color = vim.fn.fnamemodify(f, ":t:r")
--       if not vim.tbl_contains(colors, color) then
--         table.insert(colors, color)
--       end
--     end
--   end
--   return colors
-- end

-- local function snacks_theme_picker()
--   local ok, Snacks = pcall(require, "snacks")
--   if not ok then
--     return
--   end
--   -- local schemes = get_all_schemes()
--   -- local schemes = get_user_schemes2()
--   -- local items = vim.tbl_map(function(s) return { text = s } end, schemes) -- these needs to be tables, duh
--   local items = get_user_schemes2()
--   Snacks.picker.pick({
--     items = items,
--     title = "Colorschemes, ayyy",
--     format = "text",
--     preview = "colorscheme",
--     preset = "vertical",
--     confirm = function(picker, item)
--       if item then
--         picker.preview.state.colorscheme = nil
--         vim.schedule(function()
--           vim.cmd("colorscheme " .. item.text)
--         end)
--       end
--       picker:close()
--     end,
--   })
-- end

-- vim.keymap.set("n", "<leader>sC", snacks_theme_picker, { desc = "my cewl pickar" })


-- -- autoload from shada on requiring this file
-- vim.api.nvim_create_autocmd("VimEnter", {
--   once = true,
--   nested = true,
--   callback = function()
--     if vim.g.COLOR_OF_MY_PANTS then
--       vim.cmd('colorscheme ' .. vim.g.COLOR_OF_MY_PANTS)
--     end
--   end,
-- })

-- -- autosave to shada on changing the scheme
-- vim.api.nvim_create_autocmd('ColorScheme', {
--   callback = function()
--     vim.g.COLOR_OF_MY_PANTS = vim.g.colors_name
--   end
-- })

-- return schemes
