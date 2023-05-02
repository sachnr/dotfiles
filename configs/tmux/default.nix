{
  lib,
  stdenv,
  ...
}: let
  theme = import ../../theme {};
in
  stdenv.mkDerivation rec {
    name = "tmux-tpm";

    src = lib.cleanSourceWith {
      filter = name: type: let
        baseName = baseNameOf (toString name);
      in
        ! (
          lib.hasSuffix ".nix" baseName
        );
      src = lib.cleanSource ./.;
    };

    phases = ["installPhase"];

    installPhase = with theme.colors; ''
      cp -r ${src} $out
    '';
  }
