{
  lib,
  stdenv,
  pkgs,
  theme,
  ...
}: let
  substr = str: lib.strings.removePrefix "#" str;
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

    installPhase = with theme; ''
        cp -r ${src} $out
        substituteInPlace $out/autostart.conf \
          --replace "dbus-update-activation-environment" "${pkgs.dbus}/bin/dbus-update-activation-environment" \
          --replace "~/Downloads/cat.jpg" "${wallpaper}"
        substituteInPlace $out/options.conf \
          --replace "rgba(1D2021ff)" "rgba(${(substr background)}ff)" \
          --replace "rgb(8a9a7b)" "rgb(${substr brightgreen})" \
          --replace "rgb(c4746e)" "rgb(${substr brightred})" \
          --replace "rgb(a292a3)" "rgb(${substr brightpurple})"
        substituteInPlace $out/hyprpaper.conf \
          --replace "~/.config/hypr/wallpaper/Shibata_Zeshin.jpg" "${wallpaper}"
      '';
  }
