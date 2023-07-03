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

  installPhase = with theme; ''
    cp -r ${src} $out

    substituteInPlace $out/conf/theme.conf \
      --replace "color0" "${background}" \
      --replace "color1" "${red}" \
      --replace "color2" "${green}" \
      --replace "color3" "${yellow}" \
      --replace "color4" "${accent}" \
      --replace "color5" "${purple}" \
      --replace "color6" "${aqua}" \
      --replace "color7" "${gray}" \
      --replace "color8" "${brightblack}" \
      --replace "color9" "${brightred}" \
      --replace "color10" "${brightgreen}" \
      --replace "color11" "${brightyellow}" \
      --replace "color12" "${brightblue}" \
      --replace "color13" "${brightpurple}" \
      --replace "color14" "${brightaqua}" \
      --replace "color15" "${brightgray}" \
      --replace "color16" "${background}"
  '';
}
