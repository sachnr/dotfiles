{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
  hyprcfg = pkgs.callPackage ../../../pkgs/hyprland.nix {};
  hyprland-wrapped = import ../../../pkgs/hyprland-wrapped.nix {inherit pkgs;};
in
  with lib; {
    options.modules.desktop.hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "extra hyprland pkgs and user config";
      };
    };

    config = mkIf (cfg.enable) {
      home = {
        packages = with pkgs; [
          hyprpaper
          hyprland-wrapped.hyprland
        ];
        file.".config/hypr" = {
          source = hyprcfg;
          recursive = true;
        };
      };
    };
  }
