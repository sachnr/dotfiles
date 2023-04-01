{
  pkgs,
  config,
  lib,
  theme,
  user,
  inputs,
  ...
}: let
  cfg = config.modules.desktop.awesome;
  i3lockwconfig = import ./i3lock.nix {inherit pkgs theme;};
  awesome_cfg = import ../../../configs/awesome {inherit inputs lib theme pkgs;};
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
      services.xidlehook = {
        enable = true;
        not-when-audio = true;
        not-when-fullscreen = true;
        timers = [
          {
            delay = 600;
            command = "xrandr --output \"$PRIMARY_DISPLAY\" --brightness .1";
            canceller = "xrandr --output \"$PRIMARY_DISPLAY\" --brightness 1";
          }
          {
            delay = 630;
            command = "${i3lockwconfig}/bin/i3lockwconfig";
          }
        ];
      };
      # xsession.scriptPath = ".xsession-hm";
      # xsession.windowManager.awesome = {
      #   enable = true;
      # };
      home = {
        packages = with pkgs; [
          scrot
          xsel
          i3lock-color
          i3lockwconfig
          redshift
        ];
        # for startx
        # file.".xinitrc".text = ''
        #   export QT_QPA_PLATFORMTHEME=qt5ct
        #   export XDG_CURRENT_DESKTOP=awesome
        #   export XDG_SESSION_TYPE=x11
        #   ${pkgs.awesome-git}/bin/awesome
        # '';
        file.".config" = {
          source = awesome_cfg;
          recursive = true;
        };
      };
      xresources = with theme.colors; {
        extraConfig = import ./xresources.nix {inherit theme;};
      };
    };
  }
