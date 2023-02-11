{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.waylandPkgs;
in
  with lib; {
    options.modules.desktop.waylandPkgs = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "common packages for wayland";
      };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          libsForQt5.qt5.qtwayland
          dconf
          grim
          slurp
          # clipman
          swww
          wl-clipboard
          wlr-randr
          mpvpaper
          xsettingsd
        ];
      };
    };
  }
