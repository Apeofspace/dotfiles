---@diagnostic disable: unused-function
local default_config = {
  remote_path = "",
  local_path = "",
  excludes = {
    ".git/",
    ".obsidian/",
  },
}

local function construct_cmd(config, cmd)
  local possible_cmd = { "push", "pull", "check_remote", "check_local" }
  if not vim.tbl_contains(possible_cmd, cmd) then
    error("Wrong 'cmd': " .. tostring(cmd))
  end

  -- build excludes
  local excludes = {}
  for _, ex in ipairs(config.excludes or {}) do
    -- local temp = "--exclude=" .. vim.fn.shellescape(ex)
    local temp = "--exclude=" .. ex
    table.insert(excludes, temp)
  end

  -- build sources
  local src, dest
  if cmd == "push" then
    src, dest = config.local_path, config.remote_path
  elseif cmd == "pull" then
    src, dest = config.remote_path, config.local_path
  elseif cmd == "check_remote" then
    src, dest = config.remote_path, config.local_path
  elseif cmd == "check_local" then
    src, dest = config.local_path, config.remote_path
  end

  -- build args
  local base = { "rsync", "-avz", "--max-size=10m" }
  if cmd == "push" then
    table.insert(base, "--update")
    table.insert(base, "--delete")
    -- this needs further work so that local data is not lost.
  elseif cmd == "check_remote" or cmd == "check_local" then
    table.insert(base, "-i") --itemize
    table.insert(base, "--update")
    table.insert(base, "--dry-run")
  end

  local cmd_tbl = {}
  vim.list_extend(cmd_tbl, base)
  vim.list_extend(cmd_tbl, excludes)
  table.insert(cmd_tbl, src)
  table.insert(cmd_tbl, dest)
  return cmd_tbl
end

local function create_autocmds(config)
  local group = vim.api.nvim_create_augroup("notes-sync", { clear = true })

  vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { string.match(config.local_path, "^(.*)/") .. "/**" },
    group = group,
    callback = function()
      -- horrible mess of nested async functions callbacks below
      -- I don't know how to format uv async in a nice way
      vim.notify("Pull started...", vim.log.levels.INFO, { title = "Notes" })
      vim.system(construct_cmd(config, "check_local"), function(res_checklocal)
        if res_checklocal.code ~= 0 then
          vim.notify("Checking local failed: " .. tostring(res_checklocal.code),
            vim.log.levels.ERROR, { title = "Notes" })
        else
          local cmd_output = vim.split(res_checklocal.stdout, "\n")
          local incoming = {}
          for _, l in ipairs(cmd_output) do
            if #l > 0 and string.sub(l, 1, 1) == ">" then
              table.insert(incoming, string.match(l, "^.+%s(.+)"))
            end
          end
          if #incoming > 0 then
            vim.notify("Aborting pull: local contains newer files! " ..
              table.concat(incoming, "/n"), vim.log.levels.ERROR,
              { title = "Notes" })
          else
            vim.system(construct_cmd(config, "pull"), function(res_pull)
              if res_pull.code ~= 0 then
                vim.notify("Pull failed: ", vim.log.levels.ERROR,
                  { title = "Notes" })
              else
                vim.notify("Pull completed", vim.log.levels.INFO,
                  { title = "Notes" })
              end
            end)
          end
        end
      end)
    end
  })


  -- NOTE jobs stop when neovim leaves
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    pattern = { string.match(config.local_path, "^(.*)/") .. "/**" },
    group = group,
    callback = function()
      -- horrible mess of nested async functions callbacks below
      -- I don't know how to format uv async in a nice way
      vim.notify("Push started...", vim.log.levels.INFO, { title = "Notes" })
      vim.system(construct_cmd(config, "check_remote"), function(res_checkremote)
        if res_checkremote.code ~= 0 then
          vim.notify("Checking remote failed: " .. tostring(res_checkremote.code),
            vim.log.levels.ERROR, { title = "Notes" })
        else
          local cmd_output = vim.split(res_checkremote.stdout, "\n")
          local incoming = {}
          for _, l in ipairs(cmd_output) do
            if #l > 0 and string.sub(l, 1, 1) == ">" then
              table.insert(incoming, string.match(l, "^.+%s(.+)"))
            end
          end
          if #incoming > 0 then
            vim.notify("Aborting push: remote contains newer files:\n" ..
              table.concat(incoming, "/n"), vim.log.levels.ERROR,
              { title = "Notes" })
          else
            vim.system(construct_cmd(config, "push"), function(res_push)
              if res_push.code ~= 0 then
                vim.notify("Push failed: ", vim.log.levels.ERROR,
                  { title = "Notes" })
              else
                vim.notify("Push completed", vim.log.levels.INFO,
                  { title = "Notes" })
              end
            end)
          end
        end
      end)
    end
  })
end

-- this here creates nvim autocommands to push and pull notes
function Sync_setup(user_config)
  local config = vim.tbl_extend("force", default_config, user_config or {})
  config.local_path = vim.fn.expand(config.local_path)

  if vim.fn.isdirectory(config.local_path) == 0 then
    vim.notify("Not a dir: " .. config.local_path, vim.log.levels.ERROR,
      { title = "Notes" })
    return
  end

  if vim.fn.executable("rsync") ~= 1 then
    vim.notify("rsync not found in PATH", vim.log.levels.ERROR,
      { title = "Notes" })
    return
  end

  -- check if remote_path looks like ssh target, create_autocmds if not
  local addr = nil
  local rp = config.remote_path or ""
  if #rp > 0 then
    addr = string.match(rp, "^(.-):")
  end

  if addr == nil then -- SSH not needed
    create_autocmds(config)
    return
  end

  -- if ssh is needed, check that its installed, check connection to server
  -- then run create_autocmds
  if vim.fn.executable("ssh") ~= 1 then
    vim.notify("ssh not found in PATH", vim.log.levels.ERROR, { title = "Notes" })
    return
  end
  local ssh_check = { "ssh", "-o batchMode=yes", "-o ConnectTimeout=5", addr, "true" }
  vim.system(ssh_check, function(out)
    if out.code ~= 0 then
      vim.notify("Can't connect with SSH: " .. tostring(out.code),
        vim.log.levels.ERROR, { title = "Notes" })
    else
      vim.schedule(function() create_autocmds(config) end)
    end
  end)
end

-- what I need to do here is I need to manually get the list of files that need to be rsynced
-- based on modification time
-- I need to keep that cached in a file somewhere and check against that to determine conflicts
-- doesn't help resolve them tho, but will let me reliably detect and avoid conflicts

-- Need to find a way to get file date. which is easy. i would also need a dir akin to .git
-- something like .sync. Not a fan. but ohwell. What else should I keep in there?

-- okay lets think about what to do when there is a conflict. First of all, I have the exact list of 
-- conflicting files. So you shouldn't let them be pushed, thats for sure. No push on conflicting files.
-- when pulling, they can be pulled to maybe ./conflicts/ and that directory should be excluded from 
-- normal operation. And then how do i resolve the conflict? Lets say i reviewed the pulled files.

-- instead of calling functions directly, i should register user commands.
-- there should be commands for setup_auto, push, pull, push_force, pull_force


-------------- testing --------------

local test_config = {
  local_path = "/home/v/proj/test/vault_local/",
  remote_path = "/home/v/proj/test/vault_remote/",
}
Sync_setup(test_config)

-------------- real deal ------------

-- local real_config = {
--   remote_path = "vault:/backups/vault/",
--   local_path = "/home/v/ObsidianVault/",
-- }
-- Sync_setup(real_config)
