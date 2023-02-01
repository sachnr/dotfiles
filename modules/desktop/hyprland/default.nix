{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.hyprland;
  # wrapping environment variables with hyprland exe
  hyprlandwrapper = pkgs.writeShellScriptBin "hyprlandwrapped" ''
    #cursor
    export XCURSOR_SIZE=32

    # nvidia
    export WLR_NO_HARDWARE_CURSORS=1
    export GBM_BACKEND=nvidia-drm
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export LIBVA_DRIVER_NAME=nvidia
    export VDPAU_DRIVER=nvidia
    export __GL_VRR_ALLOWED=0
    export WLR_DRM_NO_ATOMIC=1
    export EGL_PLATFORM=wayland
    export WLR_BACKEND=vulkan

    # session
    export XDG_CURRENT_DESKTOP=Hyprland
    export XDG_SESSION_TYPE=wayland
    export XDG_SESSION_DESKTOP=Hyprland

    #qt
    export QT_AUTO_SCREEN_SCALE_FACTOR=1
    export QT_QPA_PLATFORM=wayland
    export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    export QT_QPA_PLATFORMTHEME=qt5ct

    # Toolkit Backend Variables
    export _JAVA_AWT_WM_NONEREPARENTING=1
    export SDL_VIDEODRIVER=wayland
    export CLUTTER_BACKEND=wayland
    export GDK_BACKEND="wayland,x11"
    export NIXOS_OZONE_WL=1

    # firefox
    export MOZ_ENABLE_WAYLAND=1

    exec Hyprland
  '';
  hyprcfg = pkgs.callPackage ../../../pkgs/hyprland.nix {};
in
  with lib; {
    options.modules.desktop.hyprland = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "extra hyprland pkgs and user config";
      };
    };

    config = mkIf (cfg.enable) {
      home = {
        packages = with pkgs; [
          egl-wayland
          hyprlandwrapper
          dconf
          grim
          slurp
          wl-clipboard
          wlr-randr
          xwayland
          hyprpaper
          mpvpaper
          xsettingsd
        ];
        file.".config/hypr" = {
          source = hyprcfg;
          recursive = true;
        };
      };

      systemd.user.targets.hyprland-session = {
        Unit = {
          Description = "hyprland compositor session";
          Documentation = ["man:systemd.special(7)"];
          BindsTo = ["graphical-session.target"];
          Wants = ["graphical-session-pre.target"];
          After = ["graphical-session-pre.target"];
        };
      };

      systemd.user.targets.tray = {
        Unit = {
          Description = "Home Manager System Tray";
          Requires = ["graphical-session-pre.target"];
        };
      };
    };
  }
