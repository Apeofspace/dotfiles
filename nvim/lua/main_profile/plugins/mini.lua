return {
  { -- Collection of various small independent plugins/modules
    "nvim-mini/mini.nvim",
    version = false,
    config = function()
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
          -- Leader triggers
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
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
          -- Window commands
          { mode = "n", keys = "<C-w>" },
          -- `z` key
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },
        clues = {
          -- Enhance this by adding descriptions for <Leader> mapping groups
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
          { mode = "n", keys = "<Leader>g",  desc = "GIT" },
          { mode = "n", keys = "<Leader>gd", desc = "Git diffview" },
          { mode = "n", keys = "<Leader>s",  desc = "PICKERS" },
          { mode = "n", keys = "<Leader>t",  desc = "Toggles" },
          { mode = "n", keys = "<Leader>w",  desc = "doesnt work for some reason" },
        },
        window = {
          delay = 0,
        },
      }
      require("mini.ai").setup({ n_lines = 500 })
      require("mini.align").setup({}) -- press gA to start
      require("mini.operators").setup({ exchange = { prefix = "" } })
      require("mini.move").setup(moveopts)
      require("mini.hipatterns").setup(hipatternsopts)
      require("mini.clue").setup(clueopts)
      -- require("mini.pairs").setup() -- too basic in many ways
      require("mini.surround").setup()
    end,
  },
  {
    "altermo/ultimate-autopair.nvim",
    event = { "InsertEnter", "CmdlineEnter" },
    -- enabled = false,
    -- branch = "v0.6", -- recommended as each new version will have breaking changes
    opts = {
      fastwarp = {   -- its WARP not WRAP (ffs smh fr fr wtf ong)
        map = "<C-l>",
        rmap = "<C-h>",
      },
    },
  },
}
