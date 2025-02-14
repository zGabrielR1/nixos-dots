{ config, pkgs, lib, inputs, ... }:

{
  config = lib.mkIf config.wm.ml4w.enable {
    # Disable default Hyprland configuration when ML4W is enabled
    wayland.windowManager.hyprland.enable = lib.mkForce false;

    home.packages = with pkgs; [
      # Hyprland core
      hyprland
      hyprpaper
      hyprpicker
      hypridle
      hyprlock
      
      # Desktop portal and notifications
      xdg-desktop-portal-hyprland
      libnotify
      dunst
      
      # Qt/GTK
      qt5.qtwayland
      qt6.qtwayland
      gtk3
      gtk4
      libadwaita
      
      # Terminal and shell
      kitty
      zsh
      zsh-completions
      fzf
      oh-my-posh
      
      # System utilities
      waybar
      rofi-wayland
      wl-clipboard
      xclip
      grim
      slurp
      cliphist
      nwg-look
      nwg-dock-hyprland
      pamixer
      pavucontrol
      playerctl
      brightnessctl
      networkmanager
      network-manager-applet
      blueman
      polkit_gnome
      
      # File management
      nautilus
      nautilus-open-any-terminal
      gvfs
      xdg-utils
      
      # Applications
      firefox
      gnome-text-editor
      gnome-calculator
      neovim
      
      # Development
      python3
      python3Packages.pip
      python3Packages.pygobject3
      
      # Theming
      papirus-icon-theme
      bibata-cursors
      breeze-icons
      
      # Fonts
      fira-code
      fira-code-nerdfont
      font-awesome
      noto-fonts
      noto-fonts-emoji
      noto-fonts-cjk
      noto-fonts-extra
      
      # ML4W specific
      hyprshade
      wlogout
      swaync
      fastfetch
      pinta
      grimblast
    ];

    # Font configuration
    fonts.fontconfig.enable = true;

    # ML4W dotfiles
    xdg.configFile = {
      # Core configs
      "hypr" = {
        source = "${inputs.ml4w-dots}/share/dotfiles/hypr";
        recursive = true;
      };
      "waybar" = {
        source = "${inputs.ml4w-dots}/share/dotfiles/waybar";
        recursive = true;
      };
      "rofi" = {
        source = "${inputs.ml4w-dots}/share/dotfiles/rofi";
        recursive = true;
      };
      "dunst" = {
        source = "${inputs.ml4w-dots}/share/dotfiles/dunst";
        recursive = true;
      };
      "kitty" = {
        source = "${inputs.ml4w-dots}/share/dotfiles/kitty";
        recursive = true;
      };

      # Additional configs
      "ml4w" = {
        source = "${inputs.ml4w-dots}/share/dotfiles/ml4w";
        recursive = true;
      };
      "wallpapers/ml4w" = {
        source = "${inputs.ml4w-dots}/share/wallpapers";
        recursive = true;
      };
    };

    # Enable services
    services = {
      blueman-applet.enable = true;
      network-manager-applet.enable = true;
    };

    # Programs configurations
    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        enableAutosuggestions = true;
        syntaxHighlighting.enable = true;
      };
    };
  };
}