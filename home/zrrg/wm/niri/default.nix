# home/zrrg/wm/niri/default.nix
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./settings.nix
    ./binds.nix
    ./rules.nix
  ];

  home.packages = with pkgs; [
    seatd
    jaq
    wofi
    dunst
    kitty
    swww # for wallpaper
    wlogout
    # Add other required packages
  ];

  wayland.windowManager.niri = {
    enable = true;
  };

  # Add necessary environment variables for Wayland
  home.sessionVariables = {
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };
} 