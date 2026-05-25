# dots

Hyprland + ecosystem dotfiles.

## Structure

```
hypr/
  hyprland.lua          # Main Lua config (Hyprland 0.55+)
  hyprland.conf         # Minimal legacy config (comments only)
  keybinds.lua          # Keybinds module
  window_rules.lua      # Window rules module
  layer_rules.lua       # Layer rules module
swaync/
  hyprland.json         # Swaync config
  hyprland-1.css        # Swaync styles
scripts/
  clipboard-tray        # Python GTK3 clipboard tray icon (cliphist)
```

## Install

```bash
# Hyprland config
cp -r hypr/* ~/.config/hypr/

# Swaync config
cp -r swaync/* ~/.config/swaync/

# Clipboard tray
cp scripts/clipboard-tray ~/.local/bin/
chmod +x ~/.local/bin/clipboard-tray
```

## Requirements

- Hyprland 0.55+ (AUR `hyprland-git`)
- `cliphist`, `wl-clipboard` — clipboard manager
- `grim`, `slurp` — screenshots
- `wofi` — app launcher / clipboard picker
- `nwg-dock-hyprland`, `nwg-drawer` — dock and drawer
- `vibepanel` — panel
- `swaync` — notifications
- `wlsunset` — blue light filter
- `glpaper` — shader wallpaper (systemd user service)

---

## Keybinds Reference

**Main modifier: `ALT`**

### Workspaces

Hyprland uses 12 named workspaces (A–L). Switch and move windows between them using the number row keys.

| Keybind | Action |
|---|---|
| `ALT + 1`–`9` | Switch to workspace **A**–**I** |
| `ALT + 0` | Switch to workspace **J** |
| `ALT + -` | Switch to workspace **K** |
| `ALT + =` | Switch to workspace **L** |
| `ALT + SHIFT + 1`–`9` | Move active window to workspace **A**–**I** and follow it |
| `ALT + SHIFT + 0` | Move active window to workspace **J** and follow it |
| `ALT + SHIFT + -` | Move active window to workspace **K** and follow it |
| `ALT + SHIFT + =` | Move active window to workspace **L** and follow it |

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
| `ALT + Tab` | Cycle focus to the **next** window (also brings it to top) |
| `ALT + SHIFT + Tab` | Cycle focus to the **previous** window |

### Scrolling Layout Navigation

The layout is set to **scrolling** — windows are arranged in columns on an infinitely growing horizontal strip. These keybinds let you navigate and manipulate columns.

#### Focus & Navigation

| Keybind | Action |
|---|---|
| `ALT + Left` | Move focus to the column on the **left**. The view scrolls to center it. Wraps around at the edges. |
| `ALT + Right` | Move focus to the column on the **right**. The view scrolls to center it. Wraps around at the edges. |
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
| `ALT + I` | **Toggle scroll inhibition** — when enabled, the view will NOT auto-scroll when focusing windows. Useful for keeping a fixed viewport. |

### Clipboard

| Keybind | Action |
|---|---|
| `CTRL + SHIFT + V` | Open clipboard history picker (**wofi** + **cliphist**). Select an entry to paste it. |

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
