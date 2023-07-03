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

    # imports = [
    #   inputs.wallpapers.homeManagerModules.default
    # ];

    config = mkIf cfg.enable {
      # programs.wall-utils = with theme; {
      #   enable = true;
      #   customCommand = "feh --bg-scale";
      #   customDir = "$HOME/wallpapers";
      #   background = black;
      #   background-alt = background;
      #   foreground = foreground;
      #   selected = blue;
      #   active = green;
      #   urgent = red;
      #   font = "RobotoMono Nerd Font 9";
      # };
      home = {
        packages = with pkgs; [
          libsForQt5.qt5.qtwayland
          qt6.qtwayland
          dconf
          grim
          slurp
          wl-clipboard
          swww
          wlr-randr
          xsettingsd
        ];
      };
    };
  }
