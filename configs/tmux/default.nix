{
  lib,
  stdenv,
  theme,
  ...
}:
stdenv.mkDerivation rec {
  name = "tmux-tpm";

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

    substituteInPlace $out/conf/theme.conf \
      --replace "color0" "${primary.background}" \
      --replace "color1" "${normal.red}" \
      --replace "color2" "${normal.green}" \
      --replace "color3" "${normal.yellow}" \
      --replace "color4" "${primary.accent}" \
      --replace "color5" "${normal.purple}" \
      --replace "color6" "${normal.cyan}" \
      --replace "color7" "${normal.gray}" \
      --replace "color8" "${bright.black}" \
      --replace "color9" "${bright.red}" \
      --replace "color10" "${bright.green}" \
      --replace "color11" "${bright.yellow}" \
      --replace "color12" "${bright.blue}" \
      --replace "color13" "${bright.purple}" \
      --replace "color14" "${bright.cyan}" \
      --replace "color15" "${bright.gray}" \
      --replace "color16" "${primary.background}"
  '';
}
