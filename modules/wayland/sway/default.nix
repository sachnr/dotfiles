{ pkgs, config, theme, lib, user, ... }:
let
  cfg = config.modules.wayland.sway;
  settings = import ./config.nix { inherit theme pkgs; };
in with lib; {
  options.modules.wayland.sway = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "sway config";
    };
  };

  config = mkIf (cfg.enable) {
    wayland.windowManager.sway = {
      enable = true;
      package = null;
      config = null;
      extraOptions = [ "--unsupported-gpu" ];
      extraConfig = settings;
      extraSessionCommands = ''
        env=GDK_BACKEND,wayland,x11,* 
        env=QT_QPA_PLATFORM,wayland;xcb 
        env=SDL_VIDEODRIVER,wayland
        env=CLUTTER_BACKEND,wayland 
        env=XDG_CURRENT_DESKTOP,Sway
        env=XDG_SESSION_TYPE,wayland
        env=XDG_SESSION_DESKTOP,Sway
        env=QT_AUTO_SCREEN_SCALE_FACTOR,1 
        env=QT_QPA_PLATFORM,wayland;xcb 
        env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1 
        env=QT_QPA_PLATFORMTHEME,qt5ct

        env=LIBVA_DRIVER_NAME,nvidia
        env=XDG_SESSION_TYPE,wayland
        env=GBM_BACKEND,nvidia-drm
        env=__GLX_VENDOR_LIBRARY_NAME,nvidia
        env=WLR_NO_HARDWARE_CURSORS,1
        env=MOZ_ENABLE_WAYLAND,1
      '';
    };

    programs.wpaperd = {
      enable = true;
      settings = {
        default = {
          path = "/home/${user}/Wallpapers";
          duration = "15m";
          sorting = "ascending";
        };
      };
    };

    home.file.".config/i3status/config.toml".text =
      import ./i3status.nix { inherit theme; };

    home = {
      packages = with pkgs; [
        grim
        slurp
        wl-clipboard
        wlr-randr
        libsForQt5.qt5.qtwayland
        qt6.qtwayland
        i3status-rust
        hyprpicker
        egl-wayland
      ];
    };

    programs.swaylock = {
      enable = true;
      settings = with theme.colors; {
        font-size = 14;
        font = theme.settings.font;
        show-failed-attempts = true;
        indicator-idle-visible = true;
        indicator-radius = 15;
        indicator-thickness = 10;
        indicator-x-position = 86;
        indicator-y-position = 1003;
        image = theme.wallpaper;
        bs-hl-color = bright.yellow;
        inside-color = "#00000000";
        inside-ver-color = normal.green;
        inside-wrong-color = bright.red;
        key-hl-color = normal.blue;
        layout-bg-color = "#00000000";
        layout-border-color = primary.background;
        layout-text-color = primary.foreground;
        line-color = primary.background;
        line-clear-color = primary.selection;
        line-caps-lock-color = bright.yellow;
        line-ver-color = normal.green;
        line-wrong-color = bright.red;
        ring-color = primary.foreground;
        ring-clear-color = primary.selection;
        ring-caps-lock-color = bright.yellow;
        ring-ver-color = normal.green;
        ring-wrong-color = bright.red;
        separator-color = primary.foreground;
        text-color = primary.foreground;
        text-clear-color = primary.foreground;
        text-caps-lock-color = primary.foreground;
        text-ver-color = primary.foreground;
        text-wrong-color = primary.foreground;
      };
    };

    services.swayidle = {
      enable = true;
      # systemdTarget = "hyprland-session.target";
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          event = "lock";
          command = "";
        }
      ];
      timeouts = [
        {
          timeout = 900;
          command = "${pkgs.swaylock}/bin/swaylock -f";
        }
        {
          timeout = 900;
          command = "${pkgs.mpc-cli}/bin/mpc pause";
        }
        {
          timeout = 910;
          command = "${pkgs.sway}/bin/swaymsg 'output * dpms off'";
          resumeCommand = "${pkgs.sway}/bin/swaymsg 'output * dpms on'";
          # command = "hyprctl dispatch dpms off";
          # resumeCommand = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
