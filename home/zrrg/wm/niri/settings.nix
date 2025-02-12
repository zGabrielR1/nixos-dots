# home/zrrg/wm/niri/settings.nix
{ config, lib, pkgs, ... }:

{
  programs.niri = {
    enable = true;
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            options = "caps:escape";
          };
          repeat-delay = 300;
          repeat-rate = 50;
        };
        touchpad = {
          natural-scroll = true;
          tap = true;
          dwt = true;
        };
      };

      layout = {
        focus-ring = {
          width = 4;
          active-color = "rgb(74, 136, 226)";
          inactive-color = "rgb(128, 128, 128)";
        };
        border = {
          width = 1;
          active-color = "rgb(74, 136, 226)";
          inactive-color = "rgb(128, 128, 128)";
        };
        gaps = 5;
      };

      animations = {
        enabled = true;
        window = {
          fade = {
            duration-ms = 150;
            curve = "ease-out-cubic";
          };
          move = {
            duration-ms = 200;
            curve = "ease-out-cubic";
          };
        };
        workspace = {
          switch = {
            duration-ms = 200;
            curve = "ease-out-cubic";
          };
        };
      };

      prefer-no-csd = false;
      cursor = {
        theme = "Adwaita";
        size = 24;
      };

      spawn-at-startup = [
        "${pkgs.dunst}/bin/dunst"
        "${pkgs.swww}/bin/swww init"
      ];
    };
  };
} 