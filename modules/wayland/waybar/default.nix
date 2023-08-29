{
  config,
  lib,
  pkgs,
  theme,
  inputs,
  system,
  ...
}: let
  cfg = config.modules.wayland.waybar;
in
  with lib; {
    options.modules.wayland.waybar = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable waybar";
      };
    };
    config = mkIf cfg.enable {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar;
        settings = import ./settings.nix {inherit pkgs theme;};
        style = import ./style.nix {inherit theme;};
      };
    };
  }
