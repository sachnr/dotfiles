{
  lib,
  stdenv,
  ...
}: let
  theme = import ../../theme {};
in
  stdenv.mkDerivation rec {
    name = "startpage";

    src = lib.cleanSourceWith {
      filter = name: type: let
        baseName = baseNameOf (toString name);
      in
        ! (
          lib.hasSuffix ".nix" baseName
        );
      src = lib.cleanSource ./.;
    };

    phases = ["installPhase"];

    installPhase = with theme.colors; ''
      cp -r ${src} $out
      substituteInPlace $out/styles.css \
        --replace "file:///image" "file:///${wallpaper}" \
        --replace "--bg: #1d2021;" "--bg: ${black};" \
        --replace "--fg: #458588;" "--fg: ${blue};" \
        --replace "--secondaryFg: #ebdbb2;" "--secondaryFg: ${foreground};" \
        --replace "--containerBg: #282828;" "--containerBg: ${background};" \
        --replace "--scrollbarColor: #83a598;" "--scrollbarColor: ${brightblue};" \
        --replace "--border: #282828;" "--border: ${black};" \
        --replace "--grey: "#a89984";" "--grey: ${gray};"
    '';
  }
