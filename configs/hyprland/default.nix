{
  lib,
  stdenv,
  pkgs,
  ...
}: let
  theme = import ../../theme {};
in
  stdenv.mkDerivation rec {
    name = "hyprlandcfg";

    src = lib.cleanSourceWith {
      filter = name: type: let
        baseName = baseNameOf (toString name);
      in
        ! (
          lib.hasSuffix ".nix" baseName
        );
      src = lib.cleanSource ./.;
    };

    installPhase = with theme.colors; ''
      cp -r ${src} $out
      substituteInPlace $out/autostart.conf \
        --replace "dbus-update-activation-environment" "${pkgs.dbus}/bin/dbus-update-activation-environment"
      substituteInPlace $out/options.conf \
        --replace "rgba(83A598ff)" "rgba(${(builtins.substring 1 6 xcolor12)}ff)" \
        --replace "rgba(1D2021ff)" "rgba(${(builtins.substring 1 6 xcolor0)}ff)" \
        --replace "rgba(1C252C90)" "rgba(${(builtins.substring 1 6 base00)}90)"
      substituteInPlace $out/hyprpaper.conf \
        --replace "~/.config/hypr/wallpaper/Shibata_Zeshin.jpg" "${wallpaper}"
    '';
  }