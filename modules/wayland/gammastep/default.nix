{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.wayland.gammastep;
in
  with lib; {
    options.modules.wayland.gammastep = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "gammstep";
      };

      config = mkIf cfg.enable {
        services.gammastep = {
          enable = true;
          dawnTime = "6:00-7:45";
          duskTime = "18:35-20:15";
          latitude = "18.59";
          longitude = "73.76";
          temperature = {
            day = "5500";
            night = "4200";
          };
        };
      };
    };
  }
