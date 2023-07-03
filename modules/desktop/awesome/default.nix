{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.desktop.awesome;
  i3lock-script = import ./i3lock.nix {inherit pkgs theme;};
in
  with lib; {
    options.modules.desktop.awesome = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "awesome basic";
      };
    };

    config = mkIf cfg.enable {
      services.xidlehook = {
        enable = true;
        not-when-audio = true;
        not-when-fullscreen = true;
        timers = [
          {
            delay = 600;
            command = "xrandr --output \"$PRIMARY_DISPLAY\" --brightness .1";
            canceller = "xrandr --output \"$PRIMARY_DISPLAY\" --brightness 1";
          }
          {
            delay = 630;
            command = "${i3lock-script}/bin/i3lock-script";
          }
        ];
      };
      home = {
        packages = with pkgs; [
          scrot
          xclip
          i3lock-color
          i3lock-script
          redshift
          dconf
        ];
      };
      xresources = {
        extraConfig = import ./xresources.nix {inherit theme;};
      };
    };
  }
