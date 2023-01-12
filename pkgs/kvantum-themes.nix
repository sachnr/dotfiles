{
  lib,
  stdenv,
  pkgs,
  fetchurl,
  ...
}: let
  theme = import ../home-manager/modules/theme {};
in
  stdenv.mkDerivation rec {
    pname = "Kvantum-themes";
    version = "v0.1";

    srcs = [
      (fetchurl {
        url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/misc/kvantum/Gruvbox.tar.gz";
        sha256 = "sha256-5k5LhrGbUFn1RmXsaik0h6nK3y0GMfePYbITfJivxg8=";
      })
      (fetchurl {
        url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/misc/kvantum/Qogir.tar.xz";
        sha256 = "sha256-kaXuorozEIq7c7CscHsCK524fxtKcvGLqBzHlMLF3Uo=";
      })
    ];

    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/Kvantum
      cp -a * $out/Kvantum
    '';
  }
