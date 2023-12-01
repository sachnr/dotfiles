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
        backend = "glx";
        settings = {
          # animations = true;
          # animation-for-open-window = "maximize";
          # animation-for-unmap-window = "squeeze";
          # animation-for-transient-window = "none";
          # dithered-present = true;
          corner-radius = 0;
          # blur = {
          #   size = 12;
          #   method = "dual_kawase";
          #   background = false;
          #   background-frame = false;
          #   strength = 5;
          # };
          shadow = false;
          # shadowOpacity = 0.7;
          # shadowExclude = [];
          vSync = false;
          # mark-wmwin-focused = true;
          # mark-ovredir-focused = true;
          detect-rounded-corners = false;
          detect-client-opacity = false;
          # use-damage = true;
          unredir-if-possible = false;
          # log-level = "warn";
        };
      };
    };
  }
