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

    programs.wpaperd = {
      enable = true;
      settings = {
        default = {
          path = "/home/${user}/wallpapers/wallpapers/starwars-new.png";
          duration = "15m";
          sorting = "ascending";
        };
      };
    };

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 1200;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };

    home.file.".config/i3status/config.toml".text =
      import ../sway/i3status.nix { inherit theme; };

    programs.hyprlock = {
      enable = true;
      extraConfig = ''
        background {
            monitor = DP-3
            path = ~/wallpapers/wallpapers/starwars-new.png
            color = rgba(25, 20, 20, 1.0)

            # all these options are taken from hyprland, see https://wiki.hyprland.org/Configuring/Variables/#blur for explanations
            blur_passes = 0 # 0 disables blurring
            blur_size = 7
            noise = 0.0117
            contrast = 0.8916
            brightness = 0.8172
            vibrancy = 0.1696
            vibrancy_darkness = 0.0
        }
        text = Hi there, $USER
        text_align = center 
        color = rgba(200, 200, 200, 1.0)
        font_size = 25
        font_family = Noto Sans
        rotate = 0 # degrees, counter-clockwise

        position = 0, 80
        halign = center
        valign = center
      '';
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
