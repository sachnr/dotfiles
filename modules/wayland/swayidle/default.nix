{ pkgs, config, lib, theme, ... }:
let cfg = config.modules.wayland.swayidle;
in with lib; {
  options.modules.wayland.swayidle = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable swaylock and swayidle";
    };
  };

  config = mkIf cfg.enable {
    programs.swaylock = {
      enable = true;
      settings = with theme.colors; {
        font-size = 14;
        font = theme.settings.font;
        show-failed-attempts = true;
        indicator-idle-visible = true;
        indicator-radius = 15;
        indicator-thickness = 10;
        indicator-x-position = 86;
        indicator-y-position = 1003;
        image = theme.wallpaper;
        bs-hl-color = bright.yellow;
        inside-color = "#00000000";
        inside-ver-color = normal.green;
        inside-wrong-color = bright.red;
        key-hl-color = normal.blue;
        layout-bg-color = "#00000000";
        layout-border-color = primary.background;
        layout-text-color = primary.foreground;
        line-color = primary.background;
        line-clear-color = primary.selection;
        line-caps-lock-color = bright.yellow;
        line-ver-color = normal.green;
        line-wrong-color = bright.red;
        ring-color = primary.foreground;
        ring-clear-color = primary.selection;
        ring-caps-lock-color = bright.yellow;
        ring-ver-color = normal.green;
        ring-wrong-color = bright.red;
        separator-color = primary.foreground;
        text-color = primary.foreground;
        text-clear-color = primary.foreground;
        text-caps-lock-color = primary.foreground;
        text-ver-color = primary.foreground;
        text-wrong-color = primary.foreground;
      };
    };

    services.swayidle = {
      enable = true;
      systemdTarget = "hyprland-session.target";
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          event = "lock";
          command = "";
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
          # command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
          # resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
          command = "hyprctl dispatch dpms off";
          resumeCommand = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
