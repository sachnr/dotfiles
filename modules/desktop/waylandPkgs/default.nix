{
  pkgs,
  config,
  lib,
  inputs,
  theme,
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

    imports = [
      inputs.wallpapers.homeManagerModules.default
    ];

    config = mkIf cfg.enable {
      programs.wall-utils = with theme.colors; {
        enable = true;
        customCommand = "swww img";
        background = base00;
        background-alt = xcolor0;
        foreground = xcolor15;
        selected = xcolor12;
        active = xcolor10;
        urgent = xcolor9;
        font = "RobotoMono Nerd Font 9";
      };
      home = {
        packages = with pkgs; [
          libsForQt5.qt5.qtwayland
          qt6.qtwayland
          dconf
          grim
          slurp
          # clipman
          # swww
          wl-clipboard
          wlr-randr
          mpvpaper
          xsettingsd
        ];
      };
    };
  }
