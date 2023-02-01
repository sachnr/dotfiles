{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  ...
}: let
in
  stdenv.mkDerivation rec {
    pname = "markdown-preview";
    version = "v0.0.10";

    src = fetchurl {
      url = "https://github.com/iamcco/markdown-preview.nvim/releases/download/${version}/markdown-preview-linux.tar.gz";
      sha256 = "sha256-letNJ3TGLpOZjEE2H+InalE07xc93aspAm0074CtRO8=";
    };

    nativeBuildInputs = [
      autoPatchelfHook
    ];

    buildInputs = [
      stdenv.cc.cc.lib
    ];

    sourceRoot = ".";

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin
      cp -a * $out/bin
      runHook postInstall
    '';
  }
