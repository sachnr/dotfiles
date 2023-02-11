{
  lib,
  stdenv,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "wallpapers";
  version = "v1";

  src = pkgs.fetchFromGitHub {
    owner = "sachnr";
    repo = "wallpapers";
    rev = "44ff5c5e3ce6702a4b31881bcc477f15e22bf225";
    sha256 = "sha256-faQ1fgS3r+2yv3B+mwRo187FNm2BmRMG2dCD9Xl+aqM=";
  };

  sourceRoot = "source";

  installPhase = ''
    mkdir -p $out/share/wallpapers
    cp -r * $out/share/wallpapers
  '';
}
