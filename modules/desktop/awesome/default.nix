{
  pkgs,
  config,
  lib,
  theme,
  user,
  ...
}: let
  cfg = config.modules.desktop.awesome;
in
  with lib; {
    options.modules.desktop.awesome = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "awesome basic";
      };
    };

    config = mkIf cfg.enable {
      # xsession.scriptPath = ".xsession-hm";
      # xsession.windowManager.awesome = {
      #   enable = true;
      # };
      home = {
        packages = with pkgs; [
          xclip
          scrot
          redshift
        ];
        # for startx
        # file.".xinitrc".text = ''
        #   export QT_QPA_PLATFORMTHEME=qt5ct
        #   export XDG_CURRENT_DESKTOP=awesome
        #   export XDG_SESSION_TYPE=x11
        #   ${pkgs.awesome-git}/bin/awesome
        # '';
      };
      xresources = with theme.colors; {
        extraConfig = import ./xresources.nix {inherit theme;};
      };
    };
  }
