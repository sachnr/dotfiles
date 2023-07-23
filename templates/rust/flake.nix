{
  description = "devshell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      rustpackage = pkgs.rustPlatform.buildRustPackage {
        pname = "rustpackage";
        version = "0.1.0";
        src = ./.;
        cargoLock.lockFile = ./Cargo.lock;
      };
    in {
      packages = {
        rustPackage = rustpackage;
      };
      defaultPackage = rustpackage;
      devShell = pkgs.mkShell {
        name = "zero";
        buildInputs = with pkgs; [
          pkg-config
        ];
      };
    });
}
