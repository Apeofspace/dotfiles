hl.window_rule({
  -- Fix some dragging issues with XWayland
  name     = "fix-xwayland-drags",
  match    = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
  name  = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move  = "20 monitor_h-120",
  float = true,
})

local mon1 = "DP-6"
local mon2 = "DP-7"

-- persistent workspaces
hl.workspace_rule({ workspace = "1", monitor = mon1, persistent = true })
hl.workspace_rule({ workspace = "2", monitor = mon1, persistent = true })
hl.workspace_rule({ workspace = "3", monitor = mon1, persistent = true })
hl.workspace_rule({ workspace = "4", monitor = mon1, persistent = true })
hl.workspace_rule({ workspace = "5", monitor = mon1, persistent = true })
hl.workspace_rule({ workspace = "6", monitor = mon2, persistent = true })
hl.workspace_rule({ workspace = "7", monitor = mon2, persistent = true })
hl.workspace_rule({ workspace = "8", monitor = mon2, persistent = true })
hl.workspace_rule({ workspace = "9", monitor = mon2, persistent = true })
hl.workspace_rule({ workspace = "10", monitor = mon2, persistent = true })

-- WORKSPACE RELATED KEYMAPS
local mainMod   = "SUPER"
local doubleMod = "ALT + CTRL"

hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- MOVEMENT
-- workspaces with numbers
for i = 1, 10 do
  local key = i % 10 -- 10 maps to key 0
  hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
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

-- HIDDEN
hl.bind(mainMod .. " + H", hl.dsp.workspace.toggle_special("magic"))

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
  -- Number keys
  for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(key, hl.dsp.window.move({ workspace = i }))
  end
  -- HIDDEN
  hl.bind("H", hl.dsp.window.move({ workspace = "special:magic" }))
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
  hl.bind("right", hl.dsp.window.resize({ x = 50, y = 0, relative = true }), opts)
  -- Exit
  hl.bind("escape", hl.dsp.submap("reset"))
  hl.bind("ALT + R", hl.dsp.submap("reset"))
end)

-- weird shit
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.layout("togglesplit")) -- dwindle only

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })   -- lmb
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- rmb
