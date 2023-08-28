{
  pkgs,
  config,
  lib,
  hyprlandpkg,
  theme,
  ...
}: let
  cfg = config.modules.wayland.swayidle;
in
  with lib; {
    options.modules.wayland.swayidle = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable swaylock and swayidle";
      };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          swaylock
        ];
      };

      programs.swaylock.settings = with theme; {
        font-size = 14;
        inherit (name) font;
        show-failed-attempts = true;
        indicator-idle-visible = true;
        indicator-radius = 100;
        indicator-thickness = 20;
        indicator-x-position = 960;
        indicator-y-position = 560;
        image = wallpaper;
        bs-hl-color = brightyellow;
        inside-color = "#00000000";
        inside-ver-color = green;
        inside-wrong-color = brightred;
        key-hl-color = blue;
        layout-bg-color = "#00000000";
        layout-border-color = background;
        layout-text-color = foreground;
        line-color = background;
        line-clear-color = selection;
        line-caps-lock-color = brightyellow;
        line-ver-color = green;
        line-wrong-color = brightred;
        ring-color = foreground;
        ring-clear-color = selection;
        ring-caps-lock-color = brightyellow;
        ring-ver-color = green;
        ring-wrong-color = brightred;
        separator-color = foreground;
        text-color = foreground;
        text-clear-color = foreground;
        text-caps-lock-color = foreground;
        text-ver-color = foreground;
        text-wrong-color = foreground;
      };

      services.swayidle = {
        enable = true;
        events = [
          {
            event = "before-sleep";
            command = "${pkgs.swaylock}/bin/swaylock -f";
          }
          {
            event = "lock";
            command = "${pkgs.swaylock}/bin/swaylock -f";
          }
        ];
        timeouts = [
          {
            timeout = 900;
            command = "${pkgs.swaylock}/bin/swaylock -f";
          }
          {
            timeout = 900;
            command = "${pkgs.mpc-cli}/bin/mpc pause";
          }
          {
            timeout = 910;
            command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
            resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
          }
        ];
      };
    };
  }
