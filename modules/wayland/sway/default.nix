{ pkgs, config, theme, lib, user, ... }:
let
  cfg = config.modules.wayland.swayConfig;
  settings = import ./config.nix { inherit theme pkgs; };
in with lib; {
  options.modules.wayland.swayConfig = {
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
  };
}
