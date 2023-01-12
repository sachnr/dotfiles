{
  lib,
  stdenv,
  pkgs,
  config,
  gtk-engine-murrine,
  ...
}: let
  theme = import ../home-manager/modules/theme {};
in
  stdenv.mkDerivation rec {
    pname = "gruvbox-gtk-theme";
    version = "9-12-2022";

    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Gruvbox-GTK-Theme";
      rev = "c3172d8dcba66f4125a014d280d41e23f0b95cad";
      sha256 = "sha256-Qqzk5TGOHn72mrM1W+hfCCiQ9U88wNEGn6YFyaisIZA=";
    };

    propagatedUserEnvPkgs = [gtk-engine-murrine];

    installPhase = ''
      mkdir -p $out/share/themes
      cp -r $src/themes/Gruvbox-Dark-B $out/share/themes
    '';
  }
