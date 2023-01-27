{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.x11;
in
  with lib; {
    options.modules.desktop.x11 = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable xerver and displaymanager";
      };
    };

    imports = [./xresources.nix];
    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          xclip
          xorg.xorgserver
          xorg.xf86inputevdev
          xorg.xf86inputsynaptics
          xorg.xf86inputlibinput
        ];
        file.".xinitrc".text = ''
          nvidia-settings --load-config-only
        '';
      };
      # Enable display manager
      xsession = {
        enable = true;
      };
    };
  }
