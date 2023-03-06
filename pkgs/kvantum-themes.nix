{
  lib,
  stdenv,
  pkgs,
  fetchurl,
  ...
}: let
  theme = import ../theme {};
in
  stdenv.mkDerivation rec {
    pname = "Kvantum-themes";
    version = "v0.1";

    srcs = [
      (fetchurl {
        url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/assets/kvantum/Qogir.tar.xz";
        sha256 = "sha256-kaXuorozEIq7c7CscHsCK524fxtKcvGLqBzHlMLF3Uo=";
      })
      (fetchurl {
        url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/assets/kvantum/Catppuccin-Mocha-Blue.tar.gz";
        sha256 = "sha256-jTCMx5GduJdsEfW8ghZSHMgPTMT0f3gop/OOln/eXA0=";
      })
      (fetchurl {
        url = "https://github.com/sachnr/gruvbox-kvantum-themes/releases/download/1.0/Gruvbox-Dark-Blue.tar.gz";
        sha256 = "sha256-iFbDgK602/4gV0NcKHgKl1D38a7UkRQNxA9iDRjyT6Q=";
      })
      (fetchurl {
        url = "https://github.com/sachnr/gruvbox-kvantum-themes/releases/download/1.0/Gruvbox_Light_Blue.tar.gz";
        sha256 = "sha256-rVqLxbuqope/ZAo60IqedeybKq0Q0JqXTnhfQ7WNagQ=";
      })
    ];

    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/Kvantum
      cp -a * $out/Kvantum
    '';
  }
