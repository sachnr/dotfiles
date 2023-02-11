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
    pname = "Everforest-GTK-Theme";
    version = "15-01-2022";

    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Everforest-GTK-Theme";
      rev = "891cf09b35465ac6c360006f081c5c324c90d4a1";
      sha256 = "sha256-zwU17L0cEpp3M0OoPHjZNpo/BKrtGHYBstePKEHQvGw=";
    };
    sourceRoot = "source";

    propagatedUserEnvPkgs = [gtk-engine-murrine];

    installPhase = ''
      mkdir -p $out/share/themes
      mkdir -p $out/share/icons
      cp -r themes/Everforest-Dark-B $out/share/themes
      cp -r themes/Everforest-Light-B $out/share/themes
      cp -r icons/* $out/share/icons
    '';
  }
