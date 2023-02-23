{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.services.mako;
in
  with lib; {
    options.modules.services.mako = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable mako";
      };
    };

    config = mkIf cfg.enable {
      programs.mako = with theme.colors; {
        enable = true;
        backgroundColor = background;
        borderColor = black;
        progressColor = green;
        textColor = foreground;
        anchor = "top-right";
        borderRadius = 8;
        borderSize = 2;
        defaultTimeout = 10000;
        font = "Roboto 11";
        groupBy = "category";
        height = 450;
        width = 200;
        margin = "20, 20, 0";
        layer = "top";
        maxIconSize = 96;
        maxVisible = 5;
        padding = "15, 15, 15";
        extraConfig = "";
      };

      home.packages = with pkgs; [
        libnotify
      ];

      systemd.user.services.mako = {
        Unit = {
          Description = "Mako notification daemon";
          After = ["graphical-session-pre.target"];
          PartOf = ["graphical-session.target"];
        };
        Service = {
          Type = "dbus";
          BusName = "org.freedesktop.Notifications";
          ExecStart = "${pkgs.mako}/bin/mako";
          RestartSec = 5;
          Restart = "always";
        };
      };
    };
  }
