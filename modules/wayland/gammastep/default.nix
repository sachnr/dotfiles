{
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
        description = "enable gammastep";
      };
    };

    config = mkIf cfg.enable {
      services.gammastep = {
        enable = true;
        dawnTime = "6:00-7:45";
        duskTime = "17:00-19:15";
        latitude = "18.59";
        longitude = "73.76";
        provider = "manual";
        tray = true;
        temperature = {
          day = 6500;
          night = 4500;
        };
      };
    };
  }
