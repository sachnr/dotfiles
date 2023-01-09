{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.services.eww;
  ewwcfg = pkgs.callPackage ../../../../pkgs/eww.nix {};
in
  with lib; {
    options.modules.services.eww = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable eww";
      };
    };

    config = mkIf (cfg.enable) {
      home = {
        packages = with pkgs; [
          eww-wayland
        ];
      };

      home.file = {
        ".config/eww" = {
          source = ewwcfg;
          recursive = true;
        };
      };

      systemd.user.services.eww = {
        Unit = {
          Description = "ElKowars wacky widgets ";
          After = ["graphical-session-pre.target"];
          PartOf = ["graphical-session.target"];
        };

        Install.WantedBy = ["hyprland-session.target"];

        Service = {
          Type = "simple";
          Environment = with pkgs; [
            "PATH=${makeBinPath [
              bash
            ]}"
          ];
          ExecStart = "${pkgs.eww-wayland}/bin/eww daemon";
          Restart = "on-abort";
        };
      };
    };
  }
