{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.services.polkit;
in
  with lib; {
    options.modules.services.polkit = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable polkit agent";
      };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          polkit_gnome
        ];
      };

      systemd.user.services.polkit-gnome-authentication-agent-1 = {
        Unit = {
          Description = "polkit-gnome-authentication-agent-1";
          After = ["graphical-session-pre.target"];
          PartOf = ["graphical-session.target"];
        };

        Install.WantedBy = ["hyprland-session.target"];

        Service = {
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
        };
      };
    };
  }
