{
  pkgs,
  config,
  hyprland,
  lib,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
  hyprcfg = pkgs.callPackage ../../../pkgs/hyprland.nix {};
  wrapped = import ./wrapper.nix {inherit pkgs;};
  wrap = pkgs.symlinkJoin {
    name = "hyprland";
    paths = [
      wrapped
      pkgs.hyprland-git
    ];
  };
in
  with lib; {
    options.modules.desktop.hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "extra hyprland pkgs and user config";
      };
    };

    imports = [
      hyprland.homeManagerModules.default
    ];

    config = mkIf (cfg.enable) {
      wayland.windowManager.hyprland = {
        enable = true;
        package = wrap;
      };

      home = {
        packages = with pkgs; [
          hyprpaper
        ];
        file.".config/hypr" = {
          source = hyprcfg;
          recursive = true;
        };
      };
    };
  }
