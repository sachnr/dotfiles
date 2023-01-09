{
  lib,
  stdenv,
  ...
}: let
  theme = import ../home-manager/modules/theme {};
in
  stdenv.mkDerivation rec {
    name = "startpage";

    src = ../configs/startpage;

    phases = ["installPhase"];

    installPhase = with theme.colors; ''
      cp -r ${src} $out
      substituteInPlace $out/styles.css \
        --replace "file:///image" "file:///${wallpaper}" \
        --replace "#458588" "${xcolor4}" \
        --replace "#ebdbb2" "${xcolor15}" \
        --replace "#3c3836" "${base01}" \
        --replace "#83a598" "${xcolor12}" \
        --replace "#282828" "${xcolor0}" \
        --replace "#a89984" "${xcolor7}" \
    '';
  }
