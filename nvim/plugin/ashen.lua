vim.pack.add({ "https://github.com/ficcdaf/ashen.nvim" })
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
