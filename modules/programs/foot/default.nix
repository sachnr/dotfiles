{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.programs.foot;
  settings = import ./settings.nix {inherit theme lib;};
in
  with lib; {
    options.modules.programs.foot = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable foot";
      };
    };

    config = mkIf cfg.enable {
      programs.foot = {
        enable = true;
      };
      home.file.".config/foot/foot.ini".text = settings;
    };
  }
