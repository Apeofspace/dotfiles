local wezterm = require("wezterm")

local M = {}

M.configure = function(config)
	config.use_fancy_tab_bar = false
	config.tab_max_width = 40
	config.status_update_interval = 1000
	config.tab_bar_at_bottom = false
	wezterm.on("update-status", function(window, pane)
		-- Workspace name
		local stat = window:active_workspace()
		local stat_color = "#f7768e"
		-- It's a little silly to have workspace name all the time
		-- Utilize this to display LDR or current key table name
		if window:active_key_table() then
			stat = window:active_key_table()
			stat_color = "#7dcfff"
		end
		if window:leader_is_active() then
			stat = "LDR"
			stat_color = "#bb9af7"
		end

		local get_basename = function(s)
			return string.gsub(s, "(.*[/\\])(.*)", "%2")
		end

		-- Current working directory
		local cwd = pane:get_current_working_dir()
		if cwd then
			if type(cwd) == "userdata" then
				-- Wezterm introduced the URL object in 20240127-113634-bbcac864
				cwd = cwd.file_path
				-- cwd = get_cwd_name(cwd.file_path)
			else
				-- 20230712-072601-f4abf8fd or earlier version
				cwd = cwd
			end
		else
			cwd = ""
		end

		-- Current command
		local cmd = pane:get_foreground_process_name()
		-- CWD and CMD could be nil (e.g. viewing log using Ctrl-Alt-l)
		cmd = cmd and get_basename(cmd) or ""

		-- Time
		local time = wezterm.strftime("%H:%M")

		-- Left status (left of the tab line)
		window:set_left_status(wezterm.format({
			{ Foreground = { Color = stat_color } },
			{ Text = "  " },
			{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
			{ Text = " | " },
			-- { Text = "" },
		}))

		-- Right status
		window:set_right_status(wezterm.format({
			-- Wezterm has a built-in nerd fonts
			-- https://wezfurlong.org/wezterm/config/lua/wezterm/nerdfonts.html
			{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
			-- { Text = " | " },
			-- { Text = wezterm.nerdfonts.cod_compass .. "  " .. window:active_workspace() },
			-- { Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
			"ResetAttributes",
			{ Text = " | " },
			{ Foreground = { Color = "#e0af68" } },
			{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
			{ Text = "  " },
		}))
	end)
	-- wezterm.on("format-tab-title", function(tab, tabs, panes, conf, hover, max_width)
	-- 	-- This function returns the suggested title for a tab.
	-- 	-- It prefers the title that was set via `tab:set_title()`
	-- 	-- or `wezterm cli set-tab-title`, but falls back to the
	-- 	-- title of the active pane in that tab.
	-- 	local function tab_title(tab_info)
	-- 		local title = tab_info.tab_title
	-- 		-- if the tab title is explicitly set, take that
	-- 		if title and #title > 0 then
	-- 			return title
	-- 		end
	-- 		-- Otherwise, use the title from the active pane
	-- 		-- in that tab
	-- 		return tab_info.active_pane.title
	-- 	end

	-- 	local title = tab_title(tab)

	-- 	local get_cwd_name = function(s)
	-- 		return string.gsub(s, "(.*[/\\])(.*)[/\\]+", "%2")
	-- 	end

	-- 	if tab.is_active then
	-- 		local cwd = panes:get_current_working_dir()
	-- 		cwd = cwd.file_path
	-- 		cwd = get_cwd_name(cwd)
	-- 		return {
	-- 			{ Background = { Color = "blue" } },
	-- 			{ Text = cwd .. " " .. title .. " " },
	-- 		}
	-- 	end
	-- 	return title
	-- end)
end

return M
