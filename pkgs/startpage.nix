{
  lib,
  stdenv,
  ...
}: let
  theme = import ../theme {};
in
  stdenv.mkDerivation rec {
    name = "startpage";

    src = ../configs/startpage;

    phases = ["installPhase"];

    installPhase = with theme.colors; ''
      cp -r ${src} $out
      substituteInPlace $out/styles.css \
        --replace "file:///image" "file:///${wallpaper}" \
        --replace "--bg: #1d2021;" "--bg: ${base00};" \
        --replace "--fg: #458588;" "--fg: ${xcolor12};" \
        --replace "--secondaryFg: #ebdbb2;" "--secondaryFg: ${xcolor15};" \
        --replace "--containerBg: #3c3836;" "--containerBg: ${base01};" \
        --replace "--scrollbarColor: #83a598;" "--scrollbarColor: ${xcolor12};" \
        --replace "--border: #282828;" "--border: ${xcolor0};" \
        --replace "--grey: "#a89984";" "--grey: ${xcolor7};"
    '';
  }
