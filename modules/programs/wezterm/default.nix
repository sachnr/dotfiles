{ pkgs, config, lib, theme, ... }:
let
  cfg = config.modules.programs.wezterm;
  extracfg = import ./extraconfig.nix { inherit theme; };
in with lib; {
  options.modules.programs.wezterm = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable wezterm";
    };
  };

  config = mkIf cfg.enable {
    programs.wezterm = {
      enable = true;
      extraConfig = extracfg;
    };
  };
}
