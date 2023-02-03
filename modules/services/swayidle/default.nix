{
  pkgs,
  config,
  lib,
  hyprlandpkg,
  theme,
  ...
}: let
  cfg = config.modules.services.swayidle;
in
  with lib; {
    options.modules.services.swayidle = {
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

      programs.swaylock.settings = with theme.colors; {
        font-size = 14;
        inherit (name) font;
        show-failed-attempts = true;
        indicator-idle-visible = true;
        indicator-radius = 100;
        indicator-thickness = 20;
        indicator-x-position = 960;
        indicator-y-position = 560;
        image = wallpaper;
        bs-hl-color = xcolor11;
        inside-color = transparent;
        inside-ver-color = xcolor2;
        inside-wrong-color = xcolor9;
        key-hl-color = xcolor4;
        layout-bg-color = transparent;
        layout-border-color = xcolor0;
        layout-text-color = xcolor15;
        line-color = xcolor0;
        line-clear-color = base01;
        line-caps-lock-color = xcolor11;
        line-ver-color = xcolor2;
        line-wrong-color = xcolor9;
        ring-color = xcolor15;
        ring-clear-color = base01;
        ring-caps-lock-color = xcolor11;
        ring-ver-color = xcolor2;
        ring-wrong-color = xcolor9;
        separator-color = xcolor15;
        text-color = xcolor15;
        text-clear-color = xcolor15;
        text-caps-lock-color = xcolor15;
        text-ver-color = xcolor15;
        text-wrong-color = xcolor15;
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
