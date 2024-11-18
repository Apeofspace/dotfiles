-- taken from. needs something to save sessions
-- https://github.com/wez/wezterm/discussions/4796
local wezterm = require("wezterm")
local helpers = require("helpers")
local act = wezterm.action
local fd = "fdfind"
local M = {}

local toggle_sesh_list = function(window, pane)
	local projects = {}

	-- get git projects in proj dir
	local success, stdout, stderr = wezterm.run_child_process({
		fd,
		"-HI",
		"^.git$",
		"--max-depth=4",
		"--prune",
		os.getenv("HOME") .. "/proj",
	})

	-- failed to run fdfind
	if not success then
		wezterm.log_error("Failed to run fdfind: " .. stderr)
		window:toast_notification("Failed to run fdfind", nil, 400)
		return
	end

	-- populate table "projects" with the results
	for line in stdout:gmatch("([^\n]*)\n?") do
		local project = line:gsub("/.git.*$", "")
		local label = project
		local id = project:gsub(".*/", "")
		table.insert(projects, { label = tostring(label), id = tostring(id) })
	end

	window:perform_action(
		act.InputSelector({
			action = wezterm.action_callback(function(win, _, id, label)
				if not id and not label then
					wezterm.log_info("Cancelled")
				else
					wezterm.log_info("Selected " .. label)
					win:perform_action(act.SwitchToWorkspace({ name = id, spawn = { cwd = label } }), pane)
					act.EmitEvent("restore_session") -- FIX why doesn't this work???
				end
			end),
			fuzzy = true,
			title = "Select project",
			choices = projects,
		}),
		pane
	)
end

-- SESSION MANAGER
-- stylua: ignore start
local session_manager = require("session-manager")
wezterm.on("save_session", function(window, pane, label) session_manager.save_state(window) end)
wezterm.on("load_session", function(window, pane) session_manager.load_state(window) end)
wezterm.on("restore_session", function(window, pane) session_manager.restore_state(window) end)
-- auto-restore
-- wezterm.on("gui-startup", function(cmd)
--   local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
--   -- maximize window when open
--   window:gui_window():maximize()
--   -- restore previous session state
--   session_manager.restore_state(window:gui_window())
-- end)
-- stylua: ignore end

-- configure hotkeys
M.configure = function(config)
	local sessionizer_keys = {
		{ key = "f", mods = "ALT", action = wezterm.action_callback(toggle_sesh_list) },
	}
	helpers.merge_keys(config, sessionizer_keys)
	local session_manager_keys = {
		{ key = "s", mods = "ALT", action = act.EmitEvent("save_session") },
		{ key = "r", mods = "ALT", action = act.EmitEvent("restore_session") },
	}
	helpers.merge_keys(config, session_manager_keys)
end

return M
