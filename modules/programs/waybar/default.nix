{
  config,
  lib,
  pkgs,
  theme,
  inputs,
  system,
  ...
}: let
  cfg = config.modules.programs.waybar;
in
  with lib; {
    options.modules.programs.waybar = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable waybar";
      };
    };
    config = mkIf cfg.enable {
      programs.waybar = {
        enable = true;
        settings = import ./settings.nix {inherit pkgs;};
        style = import ./style.nix {inherit theme;};
      };
    };
  }
