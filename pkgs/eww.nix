{
  lib,
  stdenv,
  ...
}: let
  theme = import ../home-manager/modules/theme {};
in
  stdenv.mkDerivation rec {
    name = "ewwCfg";

    src = ../configs/eww;

    phases = ["installPhase"];

    installPhase = with theme.colors; ''
      cp -r ${src} $out
      substituteInPlace $out/eww.scss \
        --replace "colors" "nixcolors" 
      substituteInPlace $out/nixcolors.scss \
        --replace "nixc00" "${base00}" \
        --replace "nixc01" "${base01}" \
        --replace "nixc02" "${base02}" \
        --replace "nixc03" "${base03}" \
        --replace "nixc04" "${base04}" \
        --replace "nixc05" "${base05}" \
        --replace "nixc06" "${base06}" \
        --replace "nixc07" "${base07}" \
        --replace "nixc08" "${base08}" \
        --replace "nixc09" "${base09}" \
        --replace "nixc0A" "${base0A}" \
        --replace "nixc0B" "${base0B}" \
        --replace "nixc0C" "${base0C}" \
        --replace "nixc0D" "${base0D}" \
        --replace "nixc0E" "${base0E}" \
        --replace "nixc0F" "${base0F}" \
        --replace "nixcx00" "${xcolor0}" \
        --replace "nixcx08" "${xcolor8}" \
        --replace "nixcx01" "${xcolor1}" \
        --replace "nixcx09" "${xcolor9}" \
        --replace "nixcx02" "${xcolor2}" \
        --replace "nixcx10" "${xcolor10}" \
        --replace "nixcx03" "${xcolor3}" \
        --replace "nixcx11" "${xcolor11}" \
        --replace "nixcx04" "${xcolor4}" \
        --replace "nixcx12" "${xcolor12}" \
        --replace "nixcx05" "${xcolor5}" \
        --replace "nixcx13" "${xcolor13}" \
        --replace "nixcx06" "${xcolor6}" \
        --replace "nixcx14" "${xcolor14}" \
        --replace "nixcx07" "${xcolor7}" \
        --replace "nixcx15" "${xcolor15}"
      substituteInPlace $out/scripts/volume \
        --replace "#ebdbb2" "${xcolor15}" \
        --replace "#fb4934" "${xcolor9}"
      substituteInPlace $out/scripts/wifi \
        --replace "#ebdbb2" "${xcolor15}" \
        --replace "#83a598" "${xcolor4}"
      substituteInPlace $out/scripts/bluetooth \
        --replace "#ebdbb2" "${xcolor15}" \
        --replace "#83a598" "${xcolor4}"
    '';
  }
