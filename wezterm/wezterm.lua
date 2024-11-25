-- this config is totally stolen from https://github.com/theopn/dotfiles/blob/main/wezterm/wezterm.lua
-- and also partly from here https://github.com/oscariquelme01/the-dotfiles/blob/master/wezterm/wezterm.lua

local wezterm = require("wezterm")

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.disable_default_keymaps = true
require("common-keymaps").configure(config)
require("tabbar").configure(config)
require("sessions").configure(config)

-- config.color_scheme = "Gruvbox"
config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	{ family = "Victor Mono", scale = 1, weight = "Medium" },
	{ family = "JetBrains Mono", scale = 1, weight = "Regular" },
	{ family = "Fira Code", scale = 1, weight = "Regular" },
})
config.font_size = 12
config.warn_about_missing_glyphs = false
config.window_background_opacity = 0.9
config.window_decorations = "NONE"
-- config.window_decorations = "RESIZE"
config.initial_rows = 45
config.initial_cols = 100
config.window_close_confirmation = "AlwaysPrompt"
config.scrollback_lines = 3000
config.default_workspace = "main"
config.term = "wezterm" -- enable the use of terminfo file (curled underlines etc)
-- check out more https://wezfurlong.org/wezterm/config/lua/config/term.html
config.max_fps = 120
-- config.front_end = "Software"
-- config.front_end = "OpenGL"
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"
-- config.webgpu_preferred_adapter = {
-- 	backend = "Vulkan",
-- 	device_type = "DiscreteGpu",
-- 	name = "NVIDIA GeForce RTX 3060",
-- }

-- Dim inactive panes
config.inactive_pane_hsb = {
	saturation = 0.24,
	brightness = 0.5,
}

config.window_padding = {
	left = "0.5cell",
	right = "0.5cell",
	top = "0.5cell",
	bottom = "0cell",
}

return config
