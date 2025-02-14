# ZRRG's NixOS Configuration

Personal NixOS configuration using Home Manager and Flakes.

## Features

- Multiple window manager support:
  - Hyprland (default configuration)
  - ML4W Hyprland (Material Design inspired configuration)
  - Awesome WM
  - Niri

## Structure

```
nixos-dots/
├── flake.nix              # Main flake configuration
├── hosts/                 # Host-specific configurations
│   └── nixos-laptop/     # Configuration for nixos-laptop
└── home/                  # Home Manager configurations
    └── zrrg/             # User configuration
        └── wm/           # Window manager configurations
            ├── hyprland/       # Default Hyprland config
            ├── hyprland-ml4w/  # ML4W Hyprland config
            ├── awesome/        # AwesomeWM config
            └── niri/          # Niri config
```

## ML4W Hyprland Integration

This configuration includes integration with [ML4W Hyprland](https://github.com/mylinuxforwork/dotfiles), a Material Design inspired Hyprland configuration.

### Features

- Material Design inspired look and feel
- Integrated waybar configuration
- Custom wallpapers
- Pre-configured applications (rofi, dunst, kitty)
- Additional utilities (hyprshade, wlogout, swaync)

### Included Packages

The ML4W configuration includes:
- Hyprland and related utilities (hyprpaper, hyprpicker, etc.)
- Desktop environment tools (waybar, rofi, dunst)
- System utilities (brightnessctl, pamixer, network tools)
- Pre-configured applications (kitty, firefox, nautilus)
- Development tools
- Theming (papirus icons, bibata cursors)
- Required fonts (Fira Code, Noto)

### Usage

To enable the ML4W configuration:

1. Edit your home configuration:
```nix
# home/zrrg/default.nix
{
  wm.ml4w.enable = true;
}
```

2. Rebuild your configuration:
```bash
sudo nixos-rebuild switch --flake .#nixos-laptop
```

To switch back to the default Hyprland configuration, set `wm.ml4w.enable = false`.

## Management

### Installation

```bash
# Clone the repository
git clone https://github.com/zrrg/nixos-dots.git
cd nixos-dots

# Build and activate the configuration
sudo nixos-rebuild switch --flake .#nixos-laptop
```

### Updates

```bash
# Update flake inputs
nix flake update

# Rebuild the system
sudo nixos-rebuild switch --flake .#nixos-laptop
