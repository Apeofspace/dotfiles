return {
  -- https://github.com/Saghen/blink.cmp
  "saghen/blink.cmp",
  lazy = false,   -- lazy loading handled internally
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  opts = {
    keymap = {
      ["<CR>"] = {
        function(cmp)   -- accept THEN show signature
          local accepted = cmp.accept()
          if accepted then
            cmp.show_signature()
          end
          return accepted
        end,
        "fallback",
      },
    },
    -- signature = { enabled = false }, -- for no reason whatsoever falkes noice already shows those
    signature = { enabled = true, window = { show_documentation = false } },
  },
}
