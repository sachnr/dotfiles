{
  lib,
  stdenv,
  pkgs,
  config,
  gtk-engine-murrine,
}: let
  theme = import ../theme {};
in
  stdenv.mkDerivation rec {
    pname = "gruvbox-gtk-theme";
    version = "9-12-2022";

    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Gruvbox-GTK-Theme";
      rev = "13fe1d7bfb43557642a37da3498cd35ba285c593";
      sha256 = "sha256-3mME+2iCph/MHl7PzY7W6H6/Npg0n0IFRijMEOF44L0=";
    };

    sourceRoot = "source";

    propagatedUserEnvPkgs = [gtk-engine-murrine];

    installPhase = ''
      mkdir -p $out/share/themes
      mkdir -p $out/share/icons
      cp -r themes/Gruvbox-Dark-B $out/share/themes
      cp -r themes/Gruvbox-Light-B $out/share/themes
      cp -r icons/Gruvbox-Dark $out/share/icons
      cp -r icons/Gruvbox-Light $out/share/icons
    '';
  }
