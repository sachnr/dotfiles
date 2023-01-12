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
    pname = "sddm-theme-nixos";
    version = "v0.1";

    src = pkgs.fetchFromGitHub {
      owner = "dmanam";
      repo = "sddm-theme-nixos";
      rev = "029ec2e77994e75ca8e9e979d6414e5718c49772";
      sha256 = "sha256-N+HckmMriJ56pFC4z5k8wkdk7DxJQEoecJB517Npaes=";
    };
    phases = ["installPhase"];

    installPhase = ''
      mkdir -p $out/share/sddm/themes/nixos-sddm
      cp -r $src/* $out/share/sddm/themes/nixos-sddm
    '';
  }
