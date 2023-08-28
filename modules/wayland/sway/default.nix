{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.wayland.sway;
in
  with lib; {
    options.modules.wayland.sway = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "sway";
      };
    };

    config = mkIf cfg.enable {
      wayland.windowManager.sway = {
        enable = true;
        config = null;
        extraConfigEarly = import ./config.nix {inherit pkgs theme;};
        extraConfig = import ./keys.nix {};
        # systemd.enable = true;
        wrapperFeatures = {
          gtk = true;
        };
        extraSessionCommands = import ./wrapper.nix {inherit pkgs;};
        extraOptions = ["--unsupported-gpu"];
      };
    };
  }
