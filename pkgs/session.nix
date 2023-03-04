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
in
  stdenv.mkDerivation rec {
    name = "sessions";

    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/wayland-sessions
      mkdir -p $out/share/xsessions
      echo "${sway}" > $out/share/wayland-sessions/sway.desktop
    '';

    passthru.providedSessions = ["sway"];
  }
