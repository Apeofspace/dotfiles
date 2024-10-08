local wezterm = require("wezterm")
local M = {}

-- Keys
function M.apply_to_config(config)
	config.leader = { key = "w", mods = "ALT", timeout_milliseconds = 1000 }
	config.key_tables = {
		resize_pane = {
			{ key = "h", action = wezterm.action.AdjustPaneSize({ "Left", 5 }) },
			{ key = "j", action = wezterm.action.AdjustPaneSize({ "Down", 5 }) },
			{ key = "k", action = wezterm.action.AdjustPaneSize({ "Up", 5 }) },
			{ key = "l", action = wezterm.action.AdjustPaneSize({ "Right", 5 }) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
		move_tab = {
			{ key = "h", action = wezterm.action.MoveTabRelative(-1) },
			{ key = "j", action = wezterm.action.MoveTabRelative(-1) },
			{ key = "k", action = wezterm.action.MoveTabRelative(1) },
			{ key = "l", action = wezterm.action.MoveTabRelative(1) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
	}
	config.keys = {
		-- Send M-w when pressing M-w twice
		{ key = "w", mods = "LEADER|ALT", action = wezterm.action.SendKey({ key = "w", mods = "ALT" }) },

		{ key = "c", mods = "LEADER", action = wezterm.action.ActivateCopyMode },
		{ key = "phys:Space", mods = "LEADER", action = wezterm.action.ActivateCommandPalette },

		-- Pane keybindings
		{ key = "s", mods = "LEADER", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "v", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "q", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
		{ key = "z", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
		-- { key = "o", mods = "LEADER", action = wezterm.action.RotatePanes("Clockwise") },
		-- We can make separate keybindings for resizing panes
		-- But Wezterm offers custom "mode" in the name of "KeyTable"
		{
			key = "r",
			mods = "LEADER",
			action = wezterm.action.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},

		-- Tab keybindings
		{ key = "t", mods = "LEADER", action = wezterm.action.SpawnTab("CurrentPaneDomain") },
		{ key = "[", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
		{ key = "]", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
		{ key = "n", mods = "LEADER", action = wezterm.action.ShowTabNavigator },
		{
			key = "e",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Renaming Tab Title...:" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
		-- Key table for moving tabs around
		{
			key = "m",
			mods = "LEADER",
			action = wezterm.action.ActivateKeyTable({ name = "move_tab", one_shot = false }),
		},
		-- Or shortcuts to move tab w/o move_tab table. SHIFT is for when caps lock is on
		{ key = "{", mods = "LEADER|SHIFT", action = wezterm.action.MoveTabRelative(-1) },
		{ key = "}", mods = "LEADER|SHIFT", action = wezterm.action.MoveTabRelative(1) },

		-- Lastly, workspace
		{ key = "w", mods = "LEADER", action = wezterm.action.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },
		{
			key = "`",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name for new workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
	}
	-- I can use the tab navigator (LDR t), but I also want to quickly navigate tabs with index
	for i = 1, 9 do
		table.insert(config.keys, {
			key = tostring(i),
			mods = "LEADER",
			action = wezterm.action.ActivateTab(i - 1),
		})
	end
end

return M
