# home/zrrg/wm/awesome/default.nix
{ config, pkgs, lib, ... }:

let
  # Fetch crystal-aura theme
  crystal-aura = pkgs.fetchFromGitHub {
    owner = "crystal-aura";  # Replace with actual owner
    repo = "crystal-aura";
    rev = "main";  # Replace with specific commit/tag
    sha256 = lib.fakeSha256;  # Replace with actual hash
  };

  # Required packages for this configuration
  awesomePackages = with pkgs; [
    # Core functionality
    awesome
    picom
    rofi
    kitty
    nitrogen
    pamixer
    brightnessctl
    networkmanagerapplet
    blueman
    pavucontrol
    xfce.thunar
    flameshot
    
    # Additional dependencies
    lua53Packages.lgi
    lua53Packages.luaposix
    lua53Packages.luadbi-mysql
    lua53Packages.luasocket
    lua53Packages.luasec
  ];
in
{
  home.packages = awesomePackages;

  xsession.windowManager.awesome = {
    enable = true;
    luaModules = with pkgs.lua53Packages; [
      lgi
      luaposix
      luadbi-mysql
      luasocket
      luasec
    ];
  };

  # Link crystal-aura configuration
  home.file = {
    ".config/awesome" = {
      source = crystal-aura;
      recursive = true;
    };
  };

  # Configure picom for compositing
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    shadow = true;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Conky'"
      "class_g ?= 'Notify-osd'"
      "class_g = 'Cairo-clock'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    settings = {
      blur = {
        method = "dual_kawase";
        strength = 5;
      };
      corner-radius = 10;
      round-borders = 1;
    };
  };

  # Additional X11 environment variables
  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # Ensure proper autostart entries
  home.file.".config/autostart" = {
    recursive = true;
    source = pkgs.writeTextDir "autostart" ''
      [Desktop Entry]
      Type=Application
      Name=Network Manager Applet
      Exec=nm-applet
      Terminal=false
      Categories=System;Settings;
      
      [Desktop Entry]
      Type=Application
      Name=Blueman Applet
      Exec=blueman-applet
      Terminal=false
      Categories=System;Settings;
    '';
  };
} 