# home/zrrg/wm/niri/binds.nix
{ config, lib, pkgs, ... }:

{
  programs.niri.settings.binds = {
    # Launcher
    Super+Space = "spawn:wofi --show drun";
    Super+Return = "spawn:kitty";

    # Window management
    Super+Q = "close";
    Super+F = "toggle-fullscreen";
    Super+Shift+Space = "toggle-floating";
    
    # Focus
    Super+Left = "focus-column-left";
    Super+Right = "focus-column-right";
    Super+Up = "focus-window-up";
    Super+Down = "focus-window-down";
    
    # Moving windows
    Super+Shift+Left = "move-window-left";
    Super+Shift+Right = "move-window-right";
    Super+Shift+Up = "move-window-up";
    Super+Shift+Down = "move-window-down";
    
    # Workspaces
    Super+1 = "focus-workspace:1";
    Super+2 = "focus-workspace:2";
    Super+3 = "focus-workspace:3";
    Super+4 = "focus-workspace:4";
    Super+5 = "focus-workspace:5";
    Super+6 = "focus-workspace:6";
    Super+7 = "focus-workspace:7";
    Super+8 = "focus-workspace:8";
    Super+9 = "focus-workspace:9";
    
    # Move windows to workspaces
    Super+Shift+1 = "move-window-to-workspace:1";
    Super+Shift+2 = "move-window-to-workspace:2";
    Super+Shift+3 = "move-window-to-workspace:3";
    Super+Shift+4 = "move-window-to-workspace:4";
    Super+Shift+5 = "move-window-to-workspace:5";
    Super+Shift+6 = "move-window-to-workspace:6";
    Super+Shift+7 = "move-window-to-workspace:7";
    Super+Shift+8 = "move-window-to-workspace:8";
    Super+Shift+9 = "move-window-to-workspace:9";
    
    # Layout
    Super+V = "split-vertical";
    Super+H = "split-horizontal";
    
    # System
    Super+Shift+E = "spawn:wlogout";
    Super+Shift+R = "reload-config";
  };
} 