{
  description = "C Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
        cm = import ./nix/cm.nix { inherit pkgs; };
      in {
        devShells.default = pkgs.mkShell {
          name = "c-env";

          stdenv = pkgs.llvmPackages_17.stdenv;

          buildInputs = with pkgs; [
            pkg-config
            clang-tools_17
            clang_17
            cmake
            cm
          ];

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ ];

          shellHook = "";
        };
      });
}
