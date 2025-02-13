{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.niri.settings.binds = with config.lib.niri.actions; let
    set-volume = spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@";
    brillo = spawn "${pkgs.brillo}/bin/brillo" "-q" "-u" "300000";
    playerctl = spawn "${pkgs.playerctl}/bin/playerctl";
  in {
    # Audio controls
    "XF86AudioMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
    "XF86AudioMicMute".action = spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
    "XF86AudioRaiseVolume".action = set-volume "5%+";
    "XF86AudioLowerVolume".action = set-volume "5%-";

    # Media controls
    "XF86AudioPlay".action = playerctl "play-pause";
    "XF86AudioStop".action = playerctl "pause";
    "XF86AudioPrev".action = playerctl "previous";
    "XF86AudioNext".action = playerctl "next";

    # Brightness controls
    "XF86MonBrightnessUp".action = brillo "-A" "5";
    "XF86MonBrightnessDown".action = brillo "-U" "5";

    # Screenshot
    "Print".action = screenshot-screen;
    "Mod+Shift+Alt+S".action = screenshot-window;
    "Mod+Shift+S".action = screenshot;

    # Applications
    "Mod+D".action = spawn "${pkgs.rofi}/bin/rofi -show drun";
    "Mod+Return".action = spawn "${pkgs.alacritty}/bin/alacritty";
    "Ctrl+Alt+L".action = spawn "swaylock";
    "Mod+U".action = spawn "env XDG_CURRENT_DESKTOP=gnome gnome-control-center";

    # Window management
    "Mod+Q".action = close-window;
    "Mod+S".action = switch-preset-column-width;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Space".action = toggle-window-floating;

    # Column management
    "Mod+Comma".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;
    "Mod+C".action = center-window;
    "Mod+Tab".action = switch-focus-between-floating-and-tiling;

    # Size management
    "Mod+Minus".action = set-column-width "-10%";
    "Mod+Plus".action = set-column-width "+10%";
    "Mod+Shift+Minus".action = set-window-height "-10%";
    "Mod+Shift+Plus".action = set-window-height "+10%";

    # Focus movement
    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+J".action = focus-window-or-workspace-down;
    "Mod+K".action = focus-window-or-workspace-up;
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Down".action = focus-workspace-down;
    "Mod+Up".action = focus-workspace-up;

    # Window movement
    "Mod+Shift+H".action = move-column-left;
    "Mod+Shift+L".action = move-column-right;
    "Mod+Shift+K".action = move-column-to-workspace-up;
    "Mod+Shift+J".action = move-column-to-workspace-down;
    "Mod+Shift+Ctrl+J".action = move-column-to-monitor-down;
    "Mod+Shift+Ctrl+K".action = move-column-to-monitor-up;
  };
}
