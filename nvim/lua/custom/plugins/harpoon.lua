-- THE PROBLEM:
-- I need to move between files and speficic places within files quickly.
-- Harpoon is almost great for it but it doesn't save places within file
-- Default marks are almost great for it. But small marks are buffer specific
-- while Capital marks are global and not project specific.
-- What I want:
-- marks that are project specific
-- marks that remember a specific place in a file
-- marks that can be shown as a GUI list in case I forgot
-- marks that are global within a project

-- return {
--   "ThePrimeagen/harpoon",
--   branch = "harpoon2",
--   enabled = true,
--   dependencies = { "nvim-lua/plenary.nvim" },
--   event = "VeryLazy",
--   config = function()
--     local harpoon = require("harpoon")
--     harpoon:setup()
--     --stylua: ignore start
--     vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(require("harpoon"):list()) end,
--       { desc = "Harpoon list" })
--     vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
--     -- for i = 1, 9 do
--     --   vim.keymap.set("n", "<leader>" .. i, function() harpoon:list():select(i) end, { desc = "Harpoon file " .. i })
--     --   -- these Ctrl mappings are added to compensate corne being ligma
--     --   vim.keymap.set("n", "<C-" .. i .. ">", function() harpoon:list():select(i) end,
--     --     { desc = "Harpoon file + Ligma " .. i })
--     -- end
--     --stylua: ignore end
--     vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end)
--     vim.keymap.set("n", "<M-s>", function() harpoon:list():select(2) end)
--     vim.keymap.set("n", "<M-d>", function() harpoon:list():select(3) end)
--     vim.keymap.set("n", "<M-f>", function() harpoon:list():select(4) end)
--
--     -- hotkeys when harpoon window is open only
--     vim.api.nvim_create_autocmd("FileType", {
--       pattern = { "harpoon" },
--       callback = function()
--         for i = 1, 9 do
--           --stylua: ignore start
--           vim.keymap.set("n", tostring(i), function() harpoon:list():select(i) end, { buffer = true })
--           --stylua: ignore end
--         end
--       end,
--     })
--   end,
-- }

-- tide is really nice but it doesnt save marks, only files
-- return {
--   {
--     "jackMort/tide.nvim",
--     opts = {
--       -- optional configuration
--     },
--     dependencies = {
--       "MunifTanjim/nui.nvim",
--       "nvim-tree/nvim-web-devicons"
--     }
--   }
-- }

-- arrow is super nice but i dont like that in-file marks are separate from global marks
-- and that default keys are numbers that are not super easy for me
-- return {
--   "otavioschwanck/arrow.nvim",
--   dependencies = {
--     { "echasnovski/mini.icons" },
--   },
--   opts = {
--     show_icons = true,
--     leader_key = ';',        -- Recommended to be a single key
--     buffer_leader_key = 'm', -- Per Buffer Mappings
--   }
-- }

-- recall is not bad but it is not project specific as it uses global marks
-- its essentially a picker for global marks thats all
-- return {
--   "fnune/recall.nvim",
--   event = "VeryLazy",
--   config = function()
--     local recall = require("recall")
--     recall.setup()
--
--     vim.keymap.set("n", ";m", recall.toggle, { noremap = true, silent = true })
--     vim.keymap.set("n", ";n", recall.goto_next, { noremap = true, silent = true })
--     vim.keymap.set("n", ";p", recall.goto_prev, { noremap = true, silent = true })
--     vim.keymap.set("n", ";c", recall.clear, { noremap = true, silent = true })
--     vim.keymap.set("n", ";;", require("recall.snacks").pick, { noremap = true, silent = true })
--   end,
-- }

-- its kinda of what I need but clunky and default configs suck
-- its also complicated as shit. but it seems like its the closest to my functionality
-- return {
--   "LeonHeidelbach/trailblazer.nvim",
--   config = function()
--     require("trailblazer").setup({})
--   end,
-- }

-- this one is real good but goddamn complicated. What I need from this is bookmarks
-- return {
--   '2kabhishek/markit.nvim',
--   dependencies = { '2kabhishek/pickme.nvim', 'nvim-lua/plenary.nvim' },
--   opts = {}, -- Add your configuration here, required if you are not calling markit.setup manually elsewhere
--   event = { 'BufReadPre', 'BufNewFile' },
-- }


return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    enabled = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(require("harpoon"):list()) end,
        { desc = "Harpoon list" })
      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add" })
      vim.keymap.set("n", "<M-a>", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<M-s>", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<M-d>", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<M-f>", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<M-g>", function() harpoon:list():select(5) end)
      -- hotkeys when harpoon window is open only
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "harpoon" },
        callback = function()
          for i = 1, 9 do
            vim.keymap.set("n", tostring(i), function() harpoon:list():select(i) end, { buffer = true })
          end
        end,
      })
    end,
  },
  { "mohseenrm/marko.nvim", opts = {} }, -- make global marks project specific
  -- {
  --   "mohseenrm/marko.nvim",
  --   config = function()
  --     local marko = require("marko")
  --     marko.setup()
  --
  --     local snacks_installed, snacks = pcall(require, "snacks")
  --     if snacks_installed then
  --       -- local function filter_built_in_marks(mark)
  --       --   if not mark:match("^[a-Z]$") then return false end
  --       --   local mark_pos = vim.fn.getpos("'" .. mark)
  --       --   return mark_pos[2] > 0
  --       -- end
  --       --
  --       -- local function custom_marks_source()
  --       --   local mark_util = require("snacks.sources.marks")
  --       --   local filtered = {}
  --       --   for _, entry in ipairs(mark_util.get_marks()) do
  --       --     if filter_built_in_marks(entry.mark) then
  --       --       table.insert(filtered, entry)
  --       --     end
  --       --   end
  --       --   return filtered
  --       -- end
  --
  --       local function custom_finder(opts, ctx)
  --         local marks = {} ---@type vim.fn.getmarklist.ret.item[]
  --         local current_buf = ctx.filter.current_buf
  --         if opts.global then
  --           vim.list_extend(marks, vim.fn.getmarklist())
  --         end
  --         if opts["local"] then
  --           vim.list_extend(marks, vim.fn.getmarklist(current_buf))
  --         end
  --
  --         local filtered_marks = {}
  --         for _, item in ipairs(marks) do
  --           if item.label:match("^[a-zA-Z]$") then
  --             table.insert(filtered_marks, item)
  --           end
  --         end
  --
  --         ---@type snacks.picker.finder.Item[]
  --         local items = {}
  --         local bufname = vim.api.nvim_buf_get_name(current_buf)
  --         for _, mark in ipairs(filtered_marks) do
  --           local file = mark.file or bufname
  --           local buf = mark.pos[1] and mark.pos[1] > 0 and mark.pos[1] or nil
  --           local line ---@type string?
  --           if buf and mark.pos[2] > 0 and vim.api.nvim_buf_is_valid(mark.pos[1]) then
  --             line = vim.api.nvim_buf_get_lines(buf, mark.pos[2] - 1, mark.pos[2], false)[1]
  --           end
  --           local label = mark.mark:sub(2, 2)
  --           items[#items + 1] = {
  --             text = table.concat({ label, file, line }, " "),
  --             label = label,
  --             line = line,
  --             buf = buf,
  --             file = file,
  --             pos = mark.pos[2] > 0 and { mark.pos[2], mark.pos[3] },
  --           }
  --         end
  --         table.sort(items, function(a, b)
  --           return a.label < b.label
  --         end)
  --         return items
  --       end
  --
  --       -- vim.keymap.set("n", "<leader>sm", function() snacks.picker.marks({ finder = custom_finder }) end)
  --     end
  --   end
  -- },
  -- {
  --   "y3owk1n/warp.nvim", -- harpoon but with no plenary
  --   config = function()
  --     local warp = require("warp")
  --     warp.setup()
  --     local map = function(key, func, desc)
  --       desc = desc or ""
  --       vim.keymap.set("n", key, func, { noremap = true, silent = true, desc = desc })
  --     end
  --     map("<leader>hh", "<cmd>WarpShowList<cr>", "Warp List")
  --     map("<leader>ha", "<cmd>WarpAddFile<cr>", "Warp Add")
  --     map("<leader>hd", "<cmd>WarpDelFile<cr>", "Warp Delete")
  --     map("<M-a>", "<cmd>WarpGoToIndex 1<cr>", "Warp file 1")
  --     map("<M-s>", "<cmd>WarpGoToIndex 2<cr>", "Warp file 2")
  --     map("<M-d>", "<cmd>WarpGoToIndex 3<cr>", "Warp file 3")
  --     map("<M-f>", "<cmd>WarpGoToIndex 4<cr>", "Warp file 4")
  --     map("<M-g>", "<cmd>WarpGoToIndex 5<cr>", "Warp file 5")
  --   end
  -- }
}
