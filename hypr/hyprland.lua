------------------
---- MONITORS ----
------------------
hl.monitor({
  output   = "",
  mode     = "preferred",
  position = "auto",
  scale    = "auto",
})

-------------------
---- AUTOSTART ----
-------------------
hl.on("hyprland.start", function()
  hl.exec_cmd("waybar -c ~/.config/hypr/waybar/config.jsonc -s  ~/.config/hypr/waybar/style.css")
  hl.exec_cmd("swaync") -- notifications
  -- hl.exec_cmd("hyprpaper")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

require("keyboard_layout")
require("keymaps")
require("workspaces")
require("lookandfeeldefault")
