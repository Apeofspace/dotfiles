---@diagnostic disable: unused-function
local default_config = {
  remote_path = "",
  local_path = "",
  excludes = {
    ".git/",
    ".obsidian/",
  },
}

local function create_autocmd()
  --
end

local function super_squash_brothers(cb)
  local reset = { "git", "reset", "--soft", }
  local commit = { "git", "commit", "-m", "SUPERSQUASH" } -- quotes?
  vim.system(reset, vim.system(commit, cb))
end

local function gen_temp_name()
  --
end

local function get_cur_branch_name()
  --
end

function Sync_setup()
  --
end

-- the idea here is to make a temp branch, hard reset 5 commits on main,
-- soft reset and recommit the rest to squash them
-- then cherrypick these comments back from the temp branch
-- the problemo is that cherry picking changes commit hash that
-- will interfere with pulling
-- And so I am afraid this idea would't work unless I could find a way to
-- cherry pick commits without changin hash.
-- so it turns out its not a problem at all. it works it seems even with
-- changed hash because it looks at the changes
-- however cherry picking itself is quite interactive.
-- so cherry picking is not it. and i cant get non interactive rebase to work

-- Below is full list of commands that need to be done to squish all commits but the latest 5
-- git branch temp1
-- git reset --hard HEAD~5
-- git branch temp2
-- git reset --soft $(git rev-list --max-parents=0 HEAD)
-- git commit -m "supersquash"
-- git rebase --onto master temp2 temp1
-- git switch master
-- git merge temp1 --ff-only
-- git branch -D temp1
-- git branch -D temp2

-- There is still some bullshit when testing this. When changing on the other side and pulling, it doesn't pull
-- correctly.
-- I could force pull, if i do it with the server. But thats risky

-- Other considertations however!!!!:
-- What if there are less commits than 5? The commands will fail.
-- I need to count commits beforehand.
-- What if temp1 and temp2 are taken?
-- I need to generate long random branch names
-- What if current branch is not master?
-- I need to check the current branch name
-- What if I fail to pull immidiately or dont have internet, and then i make changes
-- it wont let me pull again unless the changes are stashed, and then commits will be diverging. BIG PROBLEMO

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
