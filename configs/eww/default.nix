{
  lib,
  stdenv,
  ...
}: let
  theme = import ../../theme {};
in
  stdenv.mkDerivation rec {
    name = "ewwCfg";

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

      substituteInPlace $out/eww.scss \
        --replace "colors" "nixcolors"

      substituteInPlace $out/nixcolors.scss \
        --replace "backgroundnix" "${background}" \
        --replace "background2nix" "${background2}" \
        --replace "background3nix" "${background3}" \
        --replace "foregroundnix" "${foreground}" \
        --replace "selectionnix" "${selection}" \
        --replace "blacknix" "${black}" \
        --replace "rednix" "${red}" \
        --replace "greennix" "${green}" \
        --replace "yellownix" "${yellow}" \
        --replace "bluenix" "${blue}" \
        --replace "purplenix" "${purple}" \
        --replace "aquanix" "${aqua}" \
        --replace "graynix" "${gray}" \
        --replace "brightblacknx" "${brightblack}" \
        --replace "brightrednx" "${brightred}" \
        --replace "brightgreennx" "${brightgreen}" \
        --replace "brightyellownx" "${brightyellow}" \
        --replace "brightbluenx" "${brightblue}" \
        --replace "brightpurplenx" "${brightpurple}" \
        --replace "brightaquanx" "${brightaqua}" \
        --replace "brightgraynx" "${brightgray}"

      substituteInPlace $out/scripts/volume \
        --replace "#ebdbb2" "${foreground}" \
        --replace "#fb4934" "${brightred}"

      substituteInPlace $out/scripts/wifi \
        --replace "#ebdbb2" "${foreground}" \
        --replace "#83a598" "${brightgreen}"

      substituteInPlace $out/scripts/bluetooth \
        --replace "#ebdbb2" "${foreground}" \
        --replace "#83a598" "${brightgreen}"
    '';
  }
