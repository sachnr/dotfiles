{ pkgs, config, lib, theme, ... }:
let cfg = config.modules.wayland.dunst;
in with lib; {
  options.modules.wayland.dunst = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "notification daemon for sway";
    };
  };

  config = mkIf cfg.enable {
    services.dunst = with theme; {
      enable = true;
      settings = {
        global = {
          width = 400;
          height = 400;
          min_icon_size = 64;
          max_icon_size = 128;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          frame_color = "${colors.primary.accent}";
          font = "${settings.font}";
          fgcolor = "${colors.primary.foreground}";
          bgcolor = "${colors.primary.background}";
        };
        urgency_normal = {
          background = "${colors.primary.background}";
          foreground = "${colors.primary.foreground}";
          timeout = 10;
        };

        urgency_critical = {
          background = "${colors.normal.red}";
          foreground = "${colors.primary.foreground}";
          timeout = 15;
        };
      };
    };

    home.packages = with pkgs; [ libnotify ];
  };
}
