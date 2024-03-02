{ lib, stdenv, pkgs, config, ... }:
stdenv.mkDerivation rec {
  pname = "Psion_kde_theme";
  version = "Psion_7c9f80db";

  src = pkgs.fetchFromGitLab {
    domain = "git.opendesktop.org";
    owner = "phob1an";
    repo = "Psion";
    rev = "7c9f80dbd7227ec3bb379cc33851288f1cc99f17";
    sha256 = "sha256-EByn8E2ztgj7Ps92x13qXpQY5iayHupSSa9aN5v81Bc=";
  };

  phases = [ "installPhase" ];

  installPhase = let
    nix-logo = builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/NixOS/nixos-artwork/c1dc75611042b57a385c80495d3728724c35cfee/logo/white.svg";
      sha256 = "1k3ic1b1fmsar8fhms192vfyszx4xivdpak0f49zd2xh5pmabp8i";
    };
    text = ''
      source : "\"${nix-logo}\""
                      width : 123
                      height : 106'';
  in ''
    mkdir -p $out/share/
    cp -r $src/* $out/share/
    rm $out/share/README.md
    rm $out/share/Changelog
    substituteInPlace $out/share/sddm/themes/Psion/Main.qml  \
        --replace "source : \"system-users.png\"" "${text}" \
        --replace "#b0b0ae" "#ebdbb2" \
        --replace "#393939" "#1e2122"
  '';
}
