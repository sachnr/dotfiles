{
  pkgs,
  config,
  theme,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.wayland.hyprland;
  hyprcfg = pkgs.callPackage ../../../configs/hyprland {inherit theme;};
  hyprland-wrapped = import ./hyprland-wrapped.nix {inherit pkgs inputs;};
in
  with lib; {
    options.modules.wayland.hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "extra hyprland pkgs and user config";
      };
    };

    config = mkIf (cfg.enable) {
      home = {
        packages = with pkgs; [
          hyprland-wrapped.hyprland
          socat
        ];
        file.".config/hypr" = {
          source = hyprcfg;
          recursive = true;
        };
      };
    };
  }
