{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.services.picom;
in
  with lib; {
    options.modules.services.picom = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable picom";
      };
    };

    config = mkIf cfg.enable {
      services.picom = {
        enable = true;
        package = pkgs.picom-git;
        activeOpacity = 1.0;
        backend = "glx";
        settings = {
          corner-radius = 6;
          blur = {
            method = "dual_kawase";
            size = 10;
            strength = 6;
            deviation = 5.0;
            blur-background = true;
          };
          shadow = true;
          shadowOffsets = ["-15" "-15"];
          shadowOpacity = 0.7;
          shadowExclude = [];
          vSync = true;
          mark-wmwin-focused = true;
          mark-ovredir-focused = true;
          detect-rounded-corners = true;
          detect-client-opacity = true;
          use-damage = false;
          unredir-if-possible = false;
          log-level = "warn";
        };
      };
    };
  }
