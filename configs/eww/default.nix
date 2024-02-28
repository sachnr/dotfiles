{
  lib,
  stdenv,
  theme,
  ...
}:
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
      --replace "backgroundnix" "${primary.background}" \
      --replace "background2nix" "${primary.background2}" \
      --replace "background3nix" "${primary.background3}" \
      --replace "foregroundnix" "${primary.foreground}" \
      --replace "selectionnix" "${primary.selection}" \
      --replace "blacknix" "${normal.black}" \
      --replace "rednix" "${normal.red}" \
      --replace "greennix" "${normal.green}" \
      --replace "yellownix" "${normal.yellow}" \
      --replace "bluenix" "${normal.blue}" \
      --replace "purplenix" "${normal.purple}" \
      --replace "aquanix" "${normal.cyan}" \
      --replace "graynix" "${normal.gray}" \
      --replace "brightblacknx" "${bright.black}" \
      --replace "brightrednx" "${bright.red}" \
      --replace "brightgreennx" "${bright.green}" \
      --replace "brightyellownx" "${bright.yellow}" \
      --replace "brightbluenx" "${bright.blue}" \
      --replace "brightpurplenx" "${bright.purple}" \
      --replace "brightaquanx" "${bright.cyan}" \
      --replace "brightgraynx" "${bright.gray}"

    substituteInPlace $out/scripts/volume \
      --replace "#ebdbb2" "${primary.foreground}" \
      --replace "#fb4934" "${bright.red}"

    substituteInPlace $out/scripts/wifi \
      --replace "#ebdbb2" "${primary.foreground}" \
      --replace "#83a598" "${bright.green}"

    substituteInPlace $out/scripts/bluetooth \
      --replace "#ebdbb2" "${primary.foreground}" \
      --replace "#83a598" "${bright.green}"
  '';
}
