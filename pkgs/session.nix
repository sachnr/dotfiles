{
  lib,
  stdenv,
  pkgs,
  ...
}: let
  sway = ''
    [Desktop Entry]
    Name=Sway
    Comment=i3-compatible Wayland compositor
    Exec=sway
    Type=Application
  '';

  hyprland = ''
    [Desktop Entry]
    Name=Hyprland
    Comment=highly customizable dynamic tiling Wayland compositor
    Exec=Hyprland
    Type=Application
  '';
in
  stdenv.mkDerivation rec {
    name = "sessions";

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      mkdir -p $out/share/xsessions
      echo "${sway}" > $out/share/wayland-sessions/sway.desktop
      echo "${hyprland}" > $out/share/wayland-sessions/hyprland.desktop
    '';

    passthru.providedSessions = ["hyprland"];
  }
