------------------
---- MONITORS ----
------------------
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

-------------------------------
---- REQUIRES ----
-------------------------------

require("keyboard_layout")
require("workspaces")
require("lookandfeeldefault")

-------------------------------
---- KEYMAPS ----
-------------------------------

local mainMod     = "SUPER"      -- Sets "Windows" key as main modifier
local doubleMod   = "ALT + CTRL" -- Sets "Windows" key as main modifier

local terminal    = "kitty"
local fileManager = "dolphin"
local browser     = "firefox"
local launcher    = "rofi -show drun -show-icons"
local runner      = "rofi -show run"
local calc        = "rofi -show calc"


-- OPEN PROGRAMS
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(doubleMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("XF86Calculator", hl.dsp.exec_cmd(calc))
hl.bind("SHIFT + XF86Calculator", hl.dsp.exec_cmd("kcalc"))
-- hl.bind("ALT + Space", hl.dsp.exec_cmd(launcher))
-- hl.bind("ALT + SHIFT + Space", hl.dsp.exec_cmd(runner))

-- MEDIA KEYS
-- -- Laptop multimedia keys for volume and LCD brightness
-- hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
--   { locked = true, repeating = true })
-- hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
--   { locked = true, repeating = true })
-- hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
--   { locked = true, repeating = true })
-- hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
--   { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
-- hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
-- -- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl plry-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })




require("noctaliasettings")

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
  -- hl.exec_cmd("waybar -c ~/.config/hypr/waybar/config.jsonc -s  ~/.config/hypr/waybar/style.css")
  -- hl.exec_cmd("swaync") -- notifications
end)
