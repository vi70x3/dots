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
