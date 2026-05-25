-- Keybinds module for Hyprland Lua config

local mainMod = "ALT"

-- ── Workspace switching (named workspaces A-L) ───────────────
local workspace_names = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L"}
-- Key names for number row: 1-9 are "1"-"9", 10="0", 11="minus", 12="equal"
local key_names = {"1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "minus", "equal"}

for i, name in ipairs(workspace_names) do
    local key = key_names[i]
    -- Switch to workspace
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = "name:" .. name }))
    -- Move active window to workspace (follow = true moves the window and follows it)
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = "name:" .. name, follow = true }))
end

-- ── Application launchers ────────────────────────────────────
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("alacritty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd("nautilus"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("codium"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("floorp"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("gtklock"))

-- ── Window cycling ───────────────────────────────────────────
hl.bind("ALT + Tab", function()
    hl.dispatch(hl.dsp.window.cycle_next())
    hl.dispatch(hl.dsp.window.alter_zorder({ mode = "top" }))
end)

hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))

-- ── Launcher ─────────────────────────────────────────────────
hl.bind("SUPER + SUPER_L", hl.dsp.exec_cmd("nwg-drawer"))

-- ── Clipboard manager (Ctrl+Shift+V) ─────────────────────────
hl.bind("CTRL + SHIFT + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

-- ── Screenshots ──────────────────────────────────────────────
-- Print: full screen
hl.bind("Print", hl.dsp.exec_cmd("grim ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"))
-- Shift+Print: area selection
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"))
-- Ctrl+Print: active window
hl.bind("CTRL + Print", hl.dsp.exec_cmd("grim -g \"$(hyprctl activewindow -j | jq -r '\"\\(.at[0]),\\(.at[1]) \\(.size[0])x\\(.size[1])'\")\" ~/Pictures/Screenshots/$(date +%Y%m%d_%H%M%S).png"))

-- ── Mouse window drag/resize ─────────────────────────────────
hl.bind("ALT + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind("ALT + mouse:273", hl.dsp.window.resize(), { mouse = true })
