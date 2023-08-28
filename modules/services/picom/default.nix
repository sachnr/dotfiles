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
        package = pkgs.picom;
        backend = "glx";
        settings = {
          # animations = true;
          # animation-for-open-window = "maximize";
          # animation-for-unmap-window = "squeeze";
          # animation-for-transient-window = "none";
          # dithered-present = true;
          corner-radius = 6;
          blur = {
            method = "dual_kawase";
            strength = 6;
          };
          # shadow = true;
          # shadowOpacity = 0.7;
          # shadowExclude = [];
          vSync = true;
          # mark-wmwin-focused = true;
          # mark-ovredir-focused = true;
          detect-rounded-corners = true;
          detect-client-opacity = true;
          # use-damage = false;
          unredir-if-possible = false;
          # log-level = "warn";
        };
      };
    };
  }
