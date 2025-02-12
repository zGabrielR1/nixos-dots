# home/zrrg/wm/default.nix
{ config, pkgs, lib, ... }:

let
  # Get the active window manager from an environment variable or use the default
  activeWM = builtins.getEnv "ACTIVE_WM";
  defaultWM = "hyprland"; # Default to Hyprland

  # For Hyprland, get the active profile
  hyprlandProfile = builtins.getEnv "HYPRLAND_PROFILE";
  defaultHyprlandProfile = "jakoolit";
in
{
  imports = [
    # Import all window manager configurations
    ./niri
    ./hyprland
    ./awesome
  ];

  # Common packages needed across all window managers
  home.packages = with pkgs; [
    # System utilities
    pamixer
    brightnessctl
    networkmanagerapplet
    blueman
    pavucontrol
    
    # File management
    xfce.thunar
    file-roller
    
    # Screenshots and media
    flameshot
    playerctl
    
    # Theming
    qt5ct
    qt6ct
    gtk3
    gtk4
    
    # Terminal and launcher
    kitty
    wofi
    rofi
  ];

  # Common environment variables
  home.sessionVariables = {
    # Store active window manager for reference
    ACTIVE_WM = if activeWM != "" then activeWM else defaultWM;
    
    # Default applications
    TERMINAL = "kitty";
    BROWSER = "firefox";
    EDITOR = "nvim";
    
    # XDG specifications
    XDG_CURRENT_DESKTOP = if activeWM != "" then activeWM else defaultWM;
    XDG_SESSION_TYPE = if (activeWM == "awesome") then "x11" else "wayland";
    
    # Qt/GTK theming
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GTK_THEME = "Adwaita:dark";
  };

  # Common GTK settings
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    cursorTheme = {
      name = "Adwaita";
      size = 24;
    };
  };

  # Common Qt settings
  qt = {
    enable = true;
    platformTheme = "qt5ct";
    style = {
      name = "adwaita-dark";
      package = pkgs.adwaita-qt;
    };
  };

  # Common services
  services = {
    # Screen color temperature adjustment
    gammastep = {
      enable = true;
      provider = "geoclue2";
      temperature = {
        day = 6500;
        night = 3500;
      };
    };

    # Notification daemon
    dunst = {
      enable = true;
      settings = {
        global = {
          font = "Fira Code 10";
          markup = "full";
          format = "<b>%s</b>\\n%b";
          sort = true;
          indicate_hidden = true;
          alignment = "left";
          show_age_threshold = 60;
          word_wrap = true;
          ignore_newline = false;
          stack_duplicates = true;
          hide_duplicate_count = false;
          corner_radius = 8;
        };
      };
    };
  };
} 