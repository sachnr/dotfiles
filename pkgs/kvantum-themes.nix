{
  lib,
  stdenvNoCC,
  pkgs,
  fetchurl,
  ...
}: let
  theme = import ../home-manager/modules/theme {};
in
  stdenvNoCC.mkDerivation rec {
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
      (fetchurl {
        url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/misc/kvantum/Catppuccin-Mocha-Blue.tar.gz";
        sha256 = "sha256-jTCMx5GduJdsEfW8ghZSHMgPTMT0f3gop/OOln/eXA0=";
      })
    ];

    sourceRoot = ".";

    installPhase = ''
      mkdir -p $out/share/Kvantum
      cp -r * $out/share/Kvantum
    '';
  }
