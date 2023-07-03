{
  pkgs,
  config,
  lib,
  theme,
  user,
  ...
}: let
  cfg = config.modules.desktop.i3;
  opts = import ./config.nix {inherit pkgs theme;};
  rules = import ./win_rules.nix;
  keys = import ./keys.nix {inherit pkgs;};
in
  with lib; {
    options.modules.desktop.i3 = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "i3";
      };
    };

    config = mkIf cfg.enable {
      xsession = {
        enable = true;
        windowManager.i3 = {
          enable = true;
          config = null;
          extraConfig = opts + keys + rules;
        };
      };
      programs.i3status-rust = {
        enable = true;
        bars = import ./i3status-rust.nix {inherit theme;};
      };
      home = {
        packages = with pkgs; [
          xclip
        ];
        # for startx
        # file.".xinitrc".text = ''
        #   export QT_QPA_PLATFORMTHEME=qt5ct
        #   export XDG_CURRENT_DESKTOP=i3
        #   export XDG_SESSION_TYPE=x11
        #   ${pkgs.i3}/bin/i3
        # '';
      };
      xresources = with theme; {
        extraConfig = import ./xresources.nix {inherit theme;};
      };
    };
  }
