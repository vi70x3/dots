# Hyprland Configuration: vibe-panel, nwg-dock & nwg-drawer

<img width="1920" height="1080" alt="20260525_051302" src="https://github.com/user-attachments/assets/9e14c521-a420-4849-9a4d-890293387efc" />

This repository contains dotfiles for a Hyprland desktop environment built around a horizontal scrolling layout and a traditional `Alt`+`Tab` window cycling flow that will expand your windows to fullscreen or `Alt`+`<-` / `Alt`+`->` that will keep your window width and just switch between them. You can also resize windows with `Alt`+`RMB` and switch between windows with `Alt`+`LMB`, it works even on edges!

> [!TIP]
> To configure animated shader wallpapers, see [glpaper](https://github.com/vi70x3/glpaper).

> [!IMPORTANT]
> **Known Issue:** The dock is currently not stable. This behavior is likely due to the way the configuration handles window expansion during Alt+Tab, where the target window is sometimes focused but the viewport does not automatically scroll to center it.

---

## File Structure

```
hypr/
  hyprland.lua          # Main Lua configuration (Hyprland 0.55+)
  hyprland.conf         # Minimal configuration stub (comments only)
  keybinds.lua          # Keyboard shortcuts configuration module
  window_rules.lua      # Window rules and styling rules
  layer_rules.lua       # Layer-shell configuration rules
nwg-hello/
  hyprland.conf         # Dedicated Hyprland session config for the greeter
  nwg-hello.json        # Greeter configuration (sessions, themes, avatar settings)
  nwg-hello.css         # Greeter stylesheet
scripts/
  clipboard-tray        # Python GTK3 clipboard tray utility for cliphist
```

---

## Component Stack

| Component | Role |
|---|---|
| **Hyprland** (0.55+ git) | Wayland compositor configured with Lua |
| **nwg-hello** | GTK3-based login manager/greeter running via greetd |
| **vibepanel** | Top status bar (clock, system tray, indicators) |
| **nwg-dock-hyprland** | Bottom application dock configured as an overlay |
| **nwg-drawer** | Application drawer mapped to the Super key |
| **glpaper** | Animated shader wallpaper managed as a systemd user service |
| **cliphist** + **clipboard-tray** | Clipboard history manager with a system tray interface |
| **wlsunset** | Blue light filter adjustment (4500K–6500K) |

*Note: All nwg-* utilities operate as standalone programs and do not require the full nwg-shell session environment.*

---

## Installation

### Main Configuration
```bash
# Copy Hyprland configuration files
cp -r hypr/* ~/.config/hypr/

# Install the clipboard tray script
cp scripts/clipboard-tray ~/.local/bin/
chmod +x ~/.local/bin/clipboard-tray
```

### Greeter Configuration (Optional)
> [!TIP]
> `nwg-hello` is a GTK3-based greeter designed for greetd. It runs within a minimal Hyprland session to manage user login.

```bash
# 1. Install greetd and nwg-hello from your package manager (e.g., AUR for Arch)
#    Packages: greetd, nwg-hello

# 2. Copy greeter configuration files to the system directory
sudo cp -r nwg-hello/* /etc/nwg-hello/

# 3. Configure greetd to launch nwg-hello within Hyprland
sudo tee /etc/greetd/config.toml << 'EOF'
[terminal]
vt = 1

[default_session]
command = "/usr/bin/start-hyprland -- -c /etc/nwg-hello/hyprland.conf"
user = "greeter"
EOF

# 4. Enable the greetd service
sudo systemctl enable greetd.service
```

---

## Requirements

The configuration expects the following utilities and dependencies:

- **Hyprland** 0.55+ (or `hyprland-git`)
- **greetd** & **nwg-hello**
- **vibepanel**
- **nwg-dock-hyprland** & **nwg-drawer**
- **glpaper**
- **cliphist** & **wl-clipboard**
- **grim** & **slurp** (screenshot utilities)
- **wofi** (used for the clipboard history menu)
- **wlsunset**
- **alacritty** (default terminal emulator)
- **codium** (default text editor)
- **floorp** (default web browser)
- **nautilus** (default file manager)
- **gtklock**
- **hyprshutdown** (optional shutdown dialog; falls back to `hyprctl dispatch exit`)

---

## Keybinds Reference

**Main Modifier Key: `ALT`**

### Workspaces

The configuration defines 12 named workspaces (designated A through L) accessible via the number row and adjacent keys.

| Keybind | Action |
|---|---|
| `ALT + 1` to `9` | Switch to workspace **A** through **I** |
| `ALT + 0` | Switch to workspace **J** |
| `ALT + -` | Switch to workspace **K** |
| `ALT + =` | Switch to workspace **L** |
| `ALT + SHIFT + 1` to `9` | Move focused window to workspace **A** through **I** and follow focus |
| `ALT + SHIFT + 0` | Move focused window to workspace **J** and follow focus |
| `ALT + SHIFT + -` | Move focused window to workspace **K** and follow focus |
| `ALT + SHIFT + =` | Move focused window to workspace **L** and follow focus |

### Application Launchers & System Controls

| Keybind | Action |
|---|---|
| `ALT + T` | Open terminal (**Alacritty**) |
| `ALT + E` | Open editor (**VSCodium**) |
| `ALT + B` | Open browser (**Floorp**) |
| `ALT + F` | Open file manager (**Nautilus**) |
| `ALT + L` | Lock screen (**gtklock**) |
| `ALT + Q` | Close the active window |
| `ALT + V` | Toggle floating mode for the active window |
| `ALT + M` | Open power menu / exit Hyprland |
| `SUPER` | Open application drawer (**nwg-drawer**) |

### Window Cycling

| Keybind | Action |
|---|---|
| `ALT + Tab` | Focus the next window, bring it to the foreground, and scroll the view to center it |
| `ALT + SHIFT + Tab` | Focus the previous window and scroll the view to center it |

---

### Scrolling Layout Navigation

This setup utilizes a horizontal scrolling layout. Windows are organized side-by-side in columns on a virtual desktop that expands horizontally. This approach functions similarly to an expanded window switcher, keeping window sizes predictable while allowing you to pan across them.

**Focus Behavior:** The configuration disables `follow_focus` by default. Moving focus with arrow keys will change the active window but will not automatically shift the viewport. This keeps the camera position steady until you manually adjust it or use `Alt+Tab` (which centers the focused window). If you prefer the camera to track your cursor focus dynamically, toggle the follow-focus option with `ALT + I`.

#### Navigation & Viewport Scroll

| Keybind | Action |
|---|---|
| `ALT + Left` | Shift focus to the column on the left (wraps at boundary) |
| `ALT + Right` | Shift focus to the column on the right (wraps at boundary) |
| `ALT + ,` (comma) | Pan the viewport left by one column width without changing focus |
| `ALT + .` (period) | Pan the viewport right by one column width without changing focus |

#### Column Reordering

| Keybind | Action |
|---|---|
| `ALT + SHIFT + Left` | Swap the active column with the column to its left (includes edge wrapping) |
| `ALT + SHIFT + Right` | Swap the active column with the column to its right (includes edge wrapping) |

#### Column Resizing

| Keybind | Action |
|---|---|
| `ALT + R + Left` | Decrease focused column width by 10% |
| `ALT + R + Right` | Increase focused column width by 10% |
| `ALT + [` | Cycle to the previous preset column width (Presets: 33% → 50% → 67% → 100%) |
| `ALT + ]` | Cycle to the next preset column width (Presets: 33% → 50% → 67% → 100%) |
| `ALT + R + A` | Reset all columns to 50% width |

#### Column Management

| Keybind | Action |
|---|---|
| `ALT + P` | Move the focused window out of its current column and place it in a new column |
| `ALT + O` | Isolate the focused window into its own single-window column |
| `ALT + U` | Merge the focused window into the column to its left |

#### Viewport Adjustment

| Keybind | Action |
|---|---|
| `ALT + Home` | Scroll viewport to center the active column |
| `ALT + End` | Scroll viewport to display as many columns as possible simultaneously |
| `ALT + I` | Toggle the `follow-focus` mode |

---

### Clipboard Utilities

| Keybind | Action |
|---|---|
| `CTRL + SHIFT + V` | Open clipboard selection menu (**wofi** interface for **cliphist**) |

*Note: The system tray displays the **clipboard-tray** utility. Click to launch the wofi selector or right-click to view recent clipboard entries.*

### Screenshots

| Keybind | Action |
|---|---|
| `Print` | Capture the entire screen to `~/Pictures/Screenshots/` |
| `SHIFT + Print` | Capture an interactive selection region using **slurp** |
| `CTRL + Print` | Capture the currently active window |

### Mouse Bindings

| Keybind | Action |
|---|---|
| `ALT + Left-click drag` | Move the window under the cursor |
| `ALT + Right-click drag` | Resize the window under the cursor |
| `ALT + Click on screen edge` | Switch to the next window (cycles through windows) |

---

## Configuration Details

### nwg-hello.json Reference

Key parameters in `/etc/nwg-hello/nwg-hello.json`:

| Parameter | Purpose |
|---|---|
| `session_dirs` | Paths searched for session desktop entries (default: wayland-sessions and xsessions) |
| `custom_sessions` | Definitions for non-standard sessions (e.g., launching direct to bash) |
| `gtk-theme` | Selected GTK theme applied to the greeter |
| `prefer-dark-theme` | Instructs the greeter to prefer dark variations of the theme |
| `time-format` | Clock format specification (using standard strftime syntax) |
| `date-format` | Date format specification (using standard strftime syntax) |
| `avatar-show` | Toggle visibility of the user profile image |
| `avatar-circle` | Clip the user profile image to a circular mask |
| `env-vars` | Environment variables exported during session startup |

### Style Customization

To modify the login greeter style, copy the default template:

```bash
sudo cp /etc/nwg-hello/nwg-hello-default.css /etc/nwg-hello/nwg-hello.css
```

You can then edit `/etc/nwg-hello/nwg-hello.css` to adjust fonts, colors, and background imagery.

### User Icons
User profile avatars are loaded from `/var/lib/AccountsService/icons/$USERNAME`. You can configure these images using tools like `mugshot` or `gnome-control-center`.
