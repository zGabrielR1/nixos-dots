# home/zrrg/wm/hyprland/personal/default.nix
{ config, pkgs, lib, ... }:

let
  # Required packages for this configuration
  hyprlandPackages = with pkgs; [
    # Core functionality
    overskride
    networkmanagerapplet
    wdisplays
    nautilus
    pavucontrol
    wl-clipboard
    file-roller
    hyprpaper
    hyprpolkitagent
    waypaper
    hyprshot

    # Additional utilities
    waybar
    kitty
    wofi
    dunst
    swww
    wlogout
    qt5.qtwayland
    qt6.qtwayland
  ];
in
{
  home.packages = hyprlandPackages;

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      # Monitor configuration
      monitor = [
        ", preferred, auto, 1"
      ];

      # Input configuration
      input = {
        kb_layout = "us";
        follow_mouse = 1;
        touchpad = {
          natural_scroll = true;
          tap = true;
          dwt = true;
        };
      };

      # General appearance
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(88888888)";
        "col.inactive_border" = "rgba(00000088)";
      };

      # Decoration settings
      decoration = {
        rounding = 10;
        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          new_optimizations = true;
        };
        drop_shadow = true;
        shadow_range = 4;
        shadow_render_power = 3;
      };

      # Animation settings
      animations = {
        enabled = true;
        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      # Window rules
      windowrulev2 = [
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-connection-editor)$"
        "float,class:^(blueman-manager)$"
        "float,title:^(Picture-in-Picture)$"
        "workspace 2,class:^(firefox)$"
        "workspace 3,class:^(discord)$"
        "workspace 4,class:^(spotify)$"
      ];

      # Key bindings
      bind = [
        # Workspace management
        "SUPER,1,workspace,1"
        "SUPER,2,workspace,2"
        "SUPER,3,workspace,3"
        "SUPER,4,workspace,4"
        "SUPER,5,workspace,5"
        "SUPER SHIFT,1,movetoworkspace,1"
        "SUPER SHIFT,2,movetoworkspace,2"
        "SUPER SHIFT,3,movetoworkspace,3"
        "SUPER SHIFT,4,movetoworkspace,4"
        "SUPER SHIFT,5,movetoworkspace,5"

        # Window management
        "SUPER,Q,killactive,"
        "SUPER,F,fullscreen,"
        "SUPER SHIFT,Space,togglefloating,"
        "SUPER,left,movefocus,l"
        "SUPER,right,movefocus,r"
        "SUPER,up,movefocus,u"
        "SUPER,down,movefocus,d"

        # Applications
        "SUPER,Return,exec,kitty"
        "SUPER,Space,exec,wofi --show drun"
        "SUPER,E,exec,nautilus"
        "SUPER SHIFT,S,exec,hyprshot -m region"

        # System controls
        "SUPER SHIFT,Q,exit,"
        "SUPER SHIFT,R,exec,hyprctl reload"
      ];

      # Mouse bindings
      bindm = [
        "SUPER,mouse:272,movewindow"
        "SUPER,mouse:273,resizewindow"
      ];

      # Startup applications
      exec-once = [
        "waybar"
        "dunst"
        "hyprpaper"
        "nm-applet --indicator"
      ];
    };
  };

  # Additional environment variables specific to this configuration
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1"; # Electron apps hint
    HYPRSHOT_DIR = "$HOME/Pictures/Screenshots";
  };

  # XDG portal configuration
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];
  };
} 