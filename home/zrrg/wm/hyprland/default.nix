# home/zrrg/wm/hyprland/default.nix
{ config, pkgs, lib, ... }:

let
  # Configuration profiles
  profiles = {
    jakoolit = ./jakoolit;
    dotfiles = ./dotfiles;
    personal = ./personal;
  };

  # Default profile (can be changed by the user)
  defaultProfile = "jakoolit";

  # Get the active profile from an environment variable or use the default
  activeProfile = builtins.getEnv "HYPRLAND_PROFILE";
  selectedProfile = if activeProfile != "" then activeProfile else defaultProfile;
in
{
  imports = [ (profiles.${selectedProfile} or profiles.${defaultProfile}) ];

  # Common Hyprland settings that apply to all profiles
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = true;
  };

  # Common environment variables for Wayland
  home.sessionVariables = {
    CLUTTER_BACKEND = "wayland";
    GDK_BACKEND = "wayland,x11";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_QPA_PLATFORMTHEME = "qt6ct";
    QT_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # Store the active profile for reference
    HYPRLAND_ACTIVE_PROFILE = selectedProfile;
  };
} 