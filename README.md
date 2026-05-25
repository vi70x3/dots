# Hyprland + vibe-panel + nwg-dock & nwg-drawer

<img width="1920" height="1080" alt="20260525_051302" src="https://github.com/user-attachments/assets/9e14c521-a420-4849-9a4d-890293387efc" />

#### Hyprland + ecosystem dotfiles. Built around a **scrolling layout** with familiar Alt+Tab flow.


> [!TIP]
>For live wallpaper check https://github.com/vi70x3/glpaper

## Structure

```
hypr/
  hyprland.lua          # Main Lua config (Hyprland 0.55+)
  hyprland.conf         # Minimal legacy config (comments only)
  keybinds.lua          # Keybinds module
  window_rules.lua      # Window rules module
  layer_rules.lua       # Layer rules module
nwg-hello/
  hyprland.conf         # Hyprland session config for the greeter
  nwg-hello.json        # Greeter config (sessions, themes, avatar, etc.)
  nwg-hello.css         # Greeter stylesheet
scripts/
  clipboard-tray        # Python GTK3 clipboard tray icon (cliphist)
```

## Stack

| Component | Role |
|---|---|
| **Hyprland** (0.55+ git) | Wayland compositor, Lua config |
| **nwg-hello** | GTK3 login manager / greeter (greetd) |
| **vibepanel** | Top panel (clock, system tray, etc.) |
| **nwg-dock-hyprland** | Bottom dock, overlay positioning |
| **nwg-drawer** | App drawer / launcher (Super key) |
| **glpaper** | Animated shader wallpaper (systemd user service) |
| **cliphist** + **clipboard-tray** | Clipboard manager with tray icon |
| **wlsunset** | Blue light filter (4500K–6500K) |

All nwg-* tools run standalone — no nwg-shell session or dependencies required.

## Install
```bash
# Hyprland config
cp -r hypr/* ~/.config/hypr/

# Clipboard tray
cp scripts/clipboard-tray ~/.local/bin/
chmod +x ~/.local/bin/clipboard-tray
```
### for nwg-hello (optional login manager)
> [!TIP]
>nwg-hello is a GTK3-based native hyprland greeter for greetd. It handles the login screen before your Hyprland session starts.

```bash
# 1. Install greetd and nwg-hello
#    (AUR: greetd, nwg-hello)

# 2. Copy config files
sudo cp -r nwg-hello/* /etc/nwg-hello/

# 3. Configure greetd to use nwg-hello
sudo tee /etc/greetd/config.toml << 'EOF'
[terminal]
vt = 1

[default_session]
command = "/usr/bin/start-hyprland -- -c /etc/nwg-hello/hyprland.conf"
user = "greeter"
EOF

# 4. Enable greetd
sudo systemctl enable greetd.service

# 5. How it works
# - greetd runs nwg-hello as the greeter on VT1
# - nwg-hello launches a minimal Hyprland session (`/etc/nwg-hello/hyprland.conf`)
# - On successful login, nwg-hello execs your real session and Hyprland exits
```

## Requirements

- **Hyprland** 0.55+ (AUR `hyprland-git`)
- **greetd** — login daemon
- **nwg-hello** — GTK3 greeter for greetd
- **vibepanel** — panel
- **nwg-dock-hyprland** — dock
- **nwg-drawer** — app drawer / launcher
- **glpaper** — shader wallpaper (systemd user service)
- **cliphist**, **wl-clipboard** — clipboard manager
- **grim**, **slurp** — screenshots
- **wofi** — clipboard picker (Ctrl+Shift+V)
- **wlsunset** — blue light filter
- **alacritty** — terminal
- **codium** — editor
- **floorp** — browser
- **nautilus** — file manager
- **gtklock** — screen lock
- **hyprshutdown** — shutdown menu (optional, falls back to `hyprctl dispatch exit`)

---

## Keybinds Reference

**Main modifier: `ALT`**

### Workspaces

12 named workspaces (A–L). Switch and move windows using the number row.

| Keybind | Action |
|---|---|
| `ALT + 1`–`9` | Switch to workspace **A**–**I** |
| `ALT + 0` | Switch to workspace **J** |
| `ALT + -` | Switch to workspace **K** |
| `ALT + =` | Switch to workspace **L** |
| `ALT + SHIFT + 1`–`9` | Move active window to workspace **A**–**I** and follow |
| `ALT + SHIFT + 0` | Move active window to workspace **J** and follow |
| `ALT + SHIFT + -` | Move active window to workspace **K** and follow |
| `ALT + SHIFT + =` | Move active window to workspace **L** and follow |

### Application Launchers

| Keybind | Action |
|---|---|
| `ALT + T` | Open **Alacritty** terminal |
| `ALT + E` | Open **VSCodium** editor |
| `ALT + B` | Open **Floorp** browser |
| `ALT + F` | Open **Nautilus** file manager |
| `ALT + L` | Lock screen (**gtklock**) |
| `ALT + Q` | **Close** the active window |
| `ALT + V` | **Toggle floating** mode for the active window |
| `ALT + M` | **Exit** Hyprland (shutdown menu) |
| `SUPER` | Open app **drawer** (nwg-drawer) |

### Window Cycling

| Keybind | Action |
|---|---|
| `ALT + Tab` | Cycle focus to the **next** window (also brings it to top, scrolls view to it) |
| `ALT + SHIFT + Tab` | Cycle focus to the **previous** window (scrolls view to it) |

### Scrolling Layout Navigation

The layout is set to **scrolling** — windows are arranged in columns on an infinitely growing horizontal strip. Think of it as a familiar Alt+Tab window switcher, but the windows stay where you put them and you pan across them horizontally. This is the core philosophy: windows don't resize or tile themselves unexpectedly, they just sit in columns the way you'd arrange them on a wide virtual desktop.

**How it works:** `follow_focus` is **off** by default. The view stays where you left it — focusing a window with arrow keys moves focus but doesn't yank the camera around. Alt+Tab scrolls the view to the newly focused window so you always see what you switched to. Press `ALT + I` to toggle follow-focus on if you prefer the view to always track the focused window.

#### Focus & Navigation

| Keybind | Action |
|---|---|
| `ALT + Left` | Move focus to the column on the **left**. Wraps around at the edges. |
| `ALT + Right` | Move focus to the column on the **right**. Wraps around at the edges. |
| `ALT + ,` (comma) | **Scroll the view left** by one column (shifts the visible area without changing focus). |
| `ALT + .` (period) | **Scroll the view right** by one column (shifts the visible area without changing focus). |

#### Column Swapping

| Keybind | Action |
|---|---|
| `ALT + SHIFT + Left` | **Swap** the current column with its left neighbor. Wraps around — swapping the first column left moves it to the end. |
| `ALT + SHIFT + Right` | **Swap** the current column with its right neighbor. Wraps around — swapping the last column right moves it to the beginning. |

#### Column Resizing

| Keybind | Action |
|---|---|
| `ALT + R + Left` | **Shrink** the focused column width by 10% (e.g. from 50% → 40%). |
| `ALT + R + Right` | **Grow** the focused column width by 10% (e.g. from 50% → 60%). |
| `ALT + [` | Cycle to the **previous** preset column width (presets: 33% → 50% → 67% → 100%). |
| `ALT + ]` | Cycle to the **next** preset column width (presets: 33% → 50% → 67% → 100%). |
| `ALT + R + A` | **Resize all columns** to 50% width at once. |

#### Window Management Within Columns

| Keybind | Action |
|---|---|
| `ALT + P` | **Promote** the focused window into its own new column (splits it out of its current column). |
| `ALT + O` | **Expel** the focused window to a dedicated column by itself. |
| `ALT + U` | **Consume** the focused window into the previous column (merges it leftward). |

#### Fit & View

| Keybind | Action |
|---|---|
| `ALT + Home` | **Fit active** — scroll the view so the focused window's column is fully visible and centered. |
| `ALT + End` | **Fit visible** — scroll the view to show as many columns as possible on screen. |
| `ALT + I` | **Toggle follow-focus** — when ON, the view auto-scrolls to any focused window (including arrow-key navigation). When OFF (default), the view stays put and you scroll manually. |

### Clipboard

| Keybind | Action |
|---|---|
| `CTRL + SHIFT + V` | Open clipboard history picker (**wofi** + **cliphist**). Select an entry to paste it. |

The **clipboard-tray** icon sits in the system tray (powered by vibepanel). Left-click it to open the wofi picker, right-click for a menu of recent entries.

### Screenshots

| Keybind | Action |
|---|---|
| `Print` | Capture the **full screen** and save to `~/Pictures/Screenshots/`. |
| `SHIFT + Print` | Capture a **selected area** (drag to select with slurp) and save. |
| `CTRL + Print` | Capture only the **active window** and save. |

### Mouse

| Keybind | Action |
|---|---|
| `ALT + Left-click drag` | **Move** the window under the cursor. |
| `ALT + Right-click drag` | **Resize** the window under the cursor. |

### nwg-hello.json

Key configuration values:

| Key | Description |
|---|---|
| `session_dirs` | Paths to session files (default: wayland-sessions + xsessions) |
| `custom_sessions` | Add custom sessions (e.g. Shell → `/usr/bin/bash`) |
| `gtk-theme` | GTK theme for the greeter |
| `prefer-dark-theme` | Use dark variant of the theme |
| `time-format` | Clock format (strftime) |
| `date-format` | Date format (strftime) |
| `avatar-show` | Display user profile picture |
| `avatar-circle` | Draw avatar as a circle |
| `env-vars` | Environment variables to pass to the session |

### nwg-hello.css

Copy the default stylesheet and customize:

```bash
sudo cp /etc/nwg-hello/nwg-hello-default.css /etc/nwg-hello/nwg-hello.css
```

Edit `/etc/nwg-hello/nwg-hello.css` to change colors, fonts, background, etc.

### User avatars

Avatars are loaded from `/var/lib/AccountsService/icons/$USERNAME`. Use **gnome-control-center** or **mugshot** to set your profile picture.

---

