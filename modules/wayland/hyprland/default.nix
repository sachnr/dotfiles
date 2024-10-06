{ pkgs, config, theme, lib, ... }:
let
  cfg = config.modules.wayland.hyprlandConfig;
  settings = import ./settings.nix { inherit theme pkgs lib; };
in with lib; {
  options.modules.wayland.hyprlandConfig = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "extra hyprland pkgs and user config";
    };
  };

  config = mkIf (cfg.enable) {
    home.file.".config/hypr/hyprland.conf".text = settings;
    wayland.windowManager.hyprland = { enable = true; };

    programs.wpaperd = {
      enable = true;
      settings = {
        default = {
          path = "/home/${user}/wallpapers/home/";
          duration = "15m";
          sorting = "ascending";
        };
      };
    };

    home = {
      packages = with pkgs; [
        libsForQt5.qt5.qtwayland
        egl-wayland
        grim
        slurp
        i3status-rust
        hyprpicker
        wl-clipboard
        wlr-randr
        wpaperd
      ];
    };
  };
}
