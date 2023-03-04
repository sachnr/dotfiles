{
  config,
  lib,
  pkgs,
  theme,
  inputs,
  system,
  ...
}: let
  cfg = config.modules.services.polybar;
  conf = import ./config.nix {inherit theme;};
  modules = import ./modules.nix {inherit theme;};
in
  with lib; {
    options.modules.services.polybar = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable polybar";
      };
    };
    config = mkIf cfg.enable {
      services.polybar = {
        package = pkgs.polybar.override {
          alsaSupport = true;
          githubSupport = true;
          mpdSupport = true;
          pulseSupport = true;
          iwSupport = true;
          i3Support = true;
        };
        enable = true;
        script = ''
          polybar-msg cmd quit
          echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
          polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
        '';
        extraConfig = '''' + modules + conf;
      };
    };
  }
