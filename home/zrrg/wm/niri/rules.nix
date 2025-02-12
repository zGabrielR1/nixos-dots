# home/zrrg/wm/niri/rules.nix
{ config, lib, pkgs, ... }:

let
  floatingRules = [
    {
      match = {
        app-id = "^pavucontrol$";
      };
      float = true;
    }
    {
      match = {
        app-id = "^nm-connection-editor$";
      };
      float = true;
    }
    {
      match = {
        app-id = "^blueman-manager$";
      };
      float = true;
    }
    {
      match = {
        title = "^Picture-in-Picture$";
      };
      float = true;
    }
  ];

  workspaceRules = [
    {
      match = {
        app-id = "^firefox$";
      };
      workspace = 2;
    }
    {
      match = {
        class = "^discord$";
      };
      workspace = 3;
    }
    {
      match = {
        class = "^Spotify$";
      };
      workspace = 4;
    }
  ];
in
{
  programs.niri.settings.window-rules = floatingRules ++ workspaceRules;
} 