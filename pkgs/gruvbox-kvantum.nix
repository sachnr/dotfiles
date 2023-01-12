{
  lib,
  stdenv,
  pkgs,
  config,
  ...
}: let
  theme = import ../home-manager/modules/theme {};
in
  stdenv.mkDerivation rec {
    name = "gruvbox kvantum";

    src = pkgs.fetchFromGitHub {
      owner = "sachnr";
      repo = "Gruvbox-Kvantum";
      rev = "b2e642c3bedc48414fb0ba98a93497a891e1acc9";
      sha256 = "sha256-x+/POMbTvpGmgEfauyyIod2QM3o6NlFIzHD4u0QBuwg=";
    };

    phases = ["installPhase"];

    installPhase = ''
      mkdir -p $out/gruvbox-kvantum
      cp ${src}/gruvbox-kvantum/* $out/gruvbox-kvantum
    '';
  }
