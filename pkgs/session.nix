{ lib, stdenv, pkgs, ... }:
let
  hyprland = ''
    [Desktop Entry]
    Name=Hyprland
    Comment=highly customizable dynamic tiling Wayland compositor
    Exec=Hyprland
    Type=Application
  '';
in stdenv.mkDerivation rec {
  name = "sessions";

  dontUnpack = true;

  installPhase = ''
    mkdir -p $out/share/wayland-sessions
    mkdir -p $out/share/xsessions
    echo "${hyprland}" > $out/share/wayland-sessions/hyprland.desktop
  '';

  passthru.providedSessions = [ "hyprland" ];
}
