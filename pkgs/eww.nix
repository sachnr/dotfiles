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
      substituteInPlace $out/colors.scss \
        --replace "#1d2021" "${base00}" \
        --replace "#3c3836" "${base01}" \
        --replace "#504945" "${base02}" \
        --replace "#665c54" "${base03}" \
        --replace "#bdae93" "${base04}" \
        --replace "#d5c4a1" "${base05}" \
        --replace "#ebdbb2" "${base06}" \
        --replace "#fbf1c7" "${base07}" \
        --replace "#fb4934" "${base08}" \
        --replace "#fe8019" "${base09}" \
        --replace "#fabd2f" "${base0A}" \
        --replace "#b8bb26" "${base0B}" \
        --replace "#8ec07c" "${base0C}" \
        --replace "#83a598" "${base0D}" \
        --replace "#d3869b" "${base0E}" \
        --replace "#d65d0e" "${base0F}" \
        --replace "#282828" "${xcolor0}" \
        --replace "#928374" "${xcolor8}" \
        --replace "#cc241d" "${xcolor1}" \
        --replace "#fb4934" "${xcolor9}" \
        --replace "#98971a" "${xcolor2}" \
        --replace "#b8bb26" "${xcolor10}" \
        --replace "#d79921" "${xcolor3}" \
        --replace "#fabd2f" "${xcolor11}" \
        --replace "#458588" "${xcolor4}" \
        --replace "#83a598" "${xcolor12}" \
        --replace "#b16286" "${xcolor5}" \
        --replace "#d3869b" "${xcolor13}" \
        --replace "#689d6a" "${xcolor6}" \
        --replace "#8ec07c" "${xcolor14}" \
        --replace "#a89984" "${xcolor7}" \
        --replace "#ebdbb2" "${xcolor15}"
      substituteInPlace $out/scripts/volume \
        --replace "#ebdbb2" "${xcolor15}" \
        --replace "#fb4934" "${xcolor9}"
      substituteInPlace $out/scripts/wifi \
        --replace "#ebdbb2" "${xcolor15}" \
        --replace "#fb4934" "${xcolor9}"
      substituteInPlace $out/scripts/bluetooth \
        --replace "#ebdbb2" "${xcolor15}" \
        --replace "#fb4934" "${xcolor9}"
    '';
  }
