{
  lib,
  stdenv,
  pkgs,
  config,
  gtk-engine-murrine,
}: 
  stdenv.mkDerivation rec {
    pname = "tokyonight-gtk-theme";
    version = "9-12-2022";

    src = pkgs.fetchFromGitHub {
      owner = "Fausto-Korpsvart";
      repo = "Tokyo-Night-GTK-Theme";
      rev = "6e4ee110d8cbcd88b28b451595bf3a5a0ee194e1";
      sha256 = "sha256-DjDrcirM7ksb3Yu07wwUZInUr87mGI6nN420kgR+AOE=";
    };

    sourceRoot = "source";

    propagatedUserEnvPkgs = [gtk-engine-murrine];

    installPhase = ''
      mkdir -p $out/share/themes
      mkdir -p $out/share/icons
      cp -r themes/* $out/share/themes
      cp -r icons/* $out/share/icons
    '';
  }

