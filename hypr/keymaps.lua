-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more

local mainMod     = "SUPER"      -- Sets "Windows" key as main modifier
local doubleMod   = "ALT + CTRL" -- Sets "Windows" key as main modifier

local terminal    = "kitty"
local fileManager = "dolphin"
local browser     = "firefox"
local launcher    = "rofi -show drun -show-icons"
local runner      = "rofi -show run"
local calc        = "rofi -show calc"


-- OPEN PROGRAMS
hl.bind(doubleMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(doubleMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(doubleMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + Space", hl.dsp.exec_cmd(launcher))
hl.bind("ALT + SHIFT + Space", hl.dsp.exec_cmd(runner))
hl.bind("ALT + F4", hl.dsp.window.close())

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + Backspace",
  hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- MOVEMENT
-- workspaces with numbers
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- focus
-- Arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))
-- Vim keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- move windows
hl.bind("ALT + M", hl.dsp.submap("move"))
hl.define_submap("move", function()
  local opts = { repeating = true }
  -- Vim keys
  hl.bind("H", hl.dsp.window.move({ direction = "left" }), opts)
  hl.bind("J", hl.dsp.window.move({ direction = "down" }), opts)
  hl.bind("K", hl.dsp.window.move({ direction = "up" }), opts)
  hl.bind("L", hl.dsp.window.move({ direction = "right" }), opts)
  -- Arrow keys
  hl.bind("left", hl.dsp.window.move({ direction = "left" }), opts)
  hl.bind("down", hl.dsp.window.move({ direction = "down" }), opts)
  hl.bind("up", hl.dsp.window.move({ direction = "up" }), opts)
  hl.bind("right", hl.dsp.window.move({ direction = "right" }), opts)
  -- Exit
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind("ALT + M", hl.dsp.submap("reset"))
end)

-- resize
hl.bind("ALT + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
  local opts = { repeating = true }
  -- Vim keys
  hl.bind("H", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), opts)
  hl.bind("J", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), opts)
  hl.bind("K", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), opts)
  hl.bind("L", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), opts)
  -- Arrow keys
  hl.bind("left", hl.dsp.window.resize({ x = -50, y = 0, relative = true }), opts)
  hl.bind("down", hl.dsp.window.resize({ x = 0, y = -50, relative = true }), opts)
  hl.bind("up", hl.dsp.window.resize({ x = 0, y = 50, relative = true }), opts)
  hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
  hl.bind("right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), opts)
  -- Exit
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind("ALT + R", hl.dsp.submap("reset"))
end)

-- weird shit
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit")) -- dwindle only

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })   -- lmb
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- rmb
-- hl.bind(" + mouse:274", hl.dsp.window.drag(), { mouse = true })              -- mmb


-- SCRATCHPAD
hl.bind(doubleMod .. " + H", hl.dsp.workspace.toggle_special("magic"))
hl.bind(doubleMod .. " + SHIFT + H", hl.dsp.window.move({ workspace = "special:magic" }))

-- MEDIA KEYS
-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
  { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })
-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl plry-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
