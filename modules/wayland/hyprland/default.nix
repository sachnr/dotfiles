{ pkgs, config, theme, lib, user, ... }:
let
  cfg = config.modules.wayland.hyprland;
  settings = import ./settings.nix { inherit theme pkgs lib; };

in with lib; {
  options.modules.wayland.hyprland = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "extra hyprland pkgs and user config";
    };
  };

  config = mkIf (cfg.enable) {
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = true;
      extraConfig = settings;
    };

    services.wpaperd = {
      enable = true;
      settings = {
        default = {
          path = "/home/${user}/Wallpapers";
          duration = "15m";
          sorting = "ascending";
        };
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "pidof hyprlock || hyprlock";
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
        };

        listener = [
          {
            timeout = 600;
            on-timeout = "loginctl lock-session";
          }
          {
            timeout = 660;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };

    home.file.".config/i3status/config.toml".text =
      import ../sway/i3status.nix { inherit theme; };

    programs.hyprlock = {
      enable = true;
      extraConfig = import ./hyprlock.nix { inherit theme lib; };
    };

    home = {
      packages = with pkgs; [
        libsForQt5.qt5.qtwayland
        kdePackages.qtwayland # this is qt6 wayland
        egl-wayland
        grim
        slurp
        i3status-rust
        hyprpicker
        wl-clipboard
        wlr-randr
        wpaperd
        wf-recorder
      ];
    };
  };
}
