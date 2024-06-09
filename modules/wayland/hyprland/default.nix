{
  pkgs,
  config,
  theme,
  lib,
  user,
  ...
}:
let
  cfg = config.modules.wayland.hyprlandConfig;
  settings = import ./settings.nix { inherit theme pkgs lib; };
in
with lib;
{
  options.modules.wayland.hyprlandConfig = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "extra hyprland pkgs and user config";
    };
  };

  config = mkIf (cfg.enable) {
    home.file.".config/hypr/hyprland.conf".text = settings;

    home = {
      packages = with pkgs; [
        libsForQt5.qt5.qtwayland
        egl-wayland
        grim
        slurp
        wl-clipboard
        wlr-randr
        wpaperd
        swayidle
      ];
    };
  };
}
