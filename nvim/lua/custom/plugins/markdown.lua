local vault_path = vim.fn.expand("~/Obsidian Vault")

local M = {
  -- {
  --   "obsidian-nvim/obsidian.nvim",
  --   version = "*", -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = "markdown",
  --   keys = {
  --     -- { "<leader>oo", fzf_picker,           desc = "[O]bsidian [S]earch" },
  --     -- { "<leader>oo", fff_picker,        desc = "[O]bsidian [S]earch" },
  --     { "<leader>oo", snacks_picker,        desc = "[O]bsidian [S]earch" },
  --     { "<leader>ot", ":Obsidian tags<CR>", desc = "[O]bsidian [T]ags" },
  --     { "<leader>on", create_note,          desc = "[O]bsidian [N]ew" },
  --   },
  --   config = function()
  --     local obsidian = require("obsidian")
  --     obsidian.setup({
  --       workspaces = {
  --         {
  --           name = "work",
  --           path = vault_path,
  --         },
  --       },
  --       completion = { nvim_cmp = false, blink = true },
  --       legacy_commands = false, -- getting rid of errors. this is temp
  --       frontmatter = { enabled = false },
  --       note_path_func = function(spec)
  --         local path = spec.dir / tostring(spec.title)
  --         return path:with_suffix(".md")
  --       end,
  --       checkbox = {
  --         enabled = true,
  --         create_new = true,
  --         order = { " ", "x" },
  --       },
  --       footer = { enabled = false },
  --     })
  --   end,
  --   init = function()
  --     Auto_git_start() -- enable autogit on loading the plugin
  --   end,
  -- },
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown", -- Load on markdown files by default
    config = function()
      require("markdown-plus").setup({
        -- Configuration options (all optional)
        enabled = true,
        features = {
          list_management = true, -- List management features
          text_formatting = true, -- Text formatting features
          headers_toc = true,     -- Headers + TOC features
          links = true,           -- Link management features
          images = true,          -- Image link management features
          quotes = true,          -- Blockquote toggling feature
          callouts = true,        -- GFM callouts/admonitions feature
          code_block = true,      -- Code block conversion feature
          table = true,           -- Table support features
        },
        keymaps = {
          enabled = true, -- Enable default keymaps (<Plug> available for custom)
        },
        toc = {           -- TOC window configuration
          initial_depth = 2,
        },
        callouts = {         -- Callouts configuration
          default_type = "NOTE",
          custom_types = {}, -- Add custom types like { "DANGER", "SUCCESS" }
        },
        table = {            -- Table sub-configuration
          auto_format = true,
          default_alignment = "left",
          confirm_destructive = true, -- Confirm before transpose/sort operations
          keymaps = {
            enabled = true,
            prefix = "<leader>t",
            insert_mode_navigation = true, -- Alt+hjkl cell navigation
          },
        },
        filetypes = { "markdown" }, -- Filetypes to enable the plugin for
      })
    end,
    -- Auto_git_start() -- enable autogit on loading the plugin
  }
}

-- NOTE this needs plenary to work
function Auto_git_start()
  -- Set up auto pull and commit
  local group_id = vim.api.nvim_create_augroup("notes-git", { clear = true })

  -- Create auto pull on open
  local autopull = function()
    local Job = require("plenary.job")
    vim.notify("Pulling Obsidian notes", vim.log.levels.DEBUG, { title = "Obsidian" })
    Job:new({
      command = "git",
      args = { "pull" },
      on_exit = function(j, return_val)
        if return_val == 0 then
          vim.notify("Pulled Obsidian notes", vim.log.levels.INFO, { title = "Obsidian" })
        else
          vim.notify(
            "Failed to pull Obsidian notes. " .. vim.inspect(j:result()),
            vim.log.levels.ERROR,
            { title = "Obsidian" }
          )
        end
      end,
    }):start()
  end

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = vault_path .. "/**",
    callback = autopull,
    group = group_id,
  })

  local Job = require("plenary.job")

  -- Create autocommit on save
  local auto_add = function(next_func)
    return function(ev)
      Job:new({
        command = "git",
        args = { "add", ev.file },
        on_exit = function(add_j, add_return_val)
          if add_return_val ~= 0 then
            vim.notify(
              "Failed to add file to git. " .. vim.inspect(add_j:result()),
              vim.log.levels.ERROR,
              { title = "Obsidian" }
            )
            return
          end

          if next_func then
            next_func()
          end
        end,
      }):start()
    end
  end

  local auto_commit = function(next_func)
    return function()
      local date_string = os.date("%Y-%m-%d %H:%M:%S")
      Job:new({
        command = "git",
        args = { "commit", "-m", "Auto commit: " .. date_string },
        on_exit = function(commit_j, commit_return_val)
          if commit_return_val ~= 0 then
            vim.notify(
              "Failed to commit file to git. " .. vim.inspect(commit_j:result()),
              vim.log.levels.ERROR,
              { title = "Obsidian" }
            )
            return
          end
          if next_func then
            next_func()
          end
        end,
      }):start()
    end
  end

  local auto_push = function(next_func)
    return function()
      Job:new({
        command = "git",
        args = { "push" },
        on_exit = function(push_j, push_return_val)
          if push_return_val ~= 0 then
            vim.notify(
              "Failed to push Obsidian notes. " .. vim.inspect(push_j:result()),
              vim.log.levels.ERROR,
              { title = "Obsidian" }
            )
          end

          if next_func then
            next_func()
          end
        end,
      }):start()
    end
  end

  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = vault_path .. "/**",
    callback = auto_add(auto_commit(auto_push())),
    group = group_id,
  })
end

-- Enable soft word wrap for Markdown files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.wrap = true        -- Enable soft line wrapping
    vim.opt_local.linebreak = true   -- Wrap at word boundaries, not in the middle of a word
    vim.opt_local.breakindent = true -- Indent wrapped lines to align with the start of the text
    -- vim.opt_local.conceallevel = 2   --  I hate conceal
    vim.opt_local.conceallevel = 1
  end,
})

return M
