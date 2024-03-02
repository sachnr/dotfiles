{
  description = "Zig Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig.url = "github:mitchellh/zig-overlay";
    zigls.url = "github:zigtools/zls";
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let pkgs = import inputs.nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          name = "Zig";
          nativeBuildInputs = [
            inputs.zig.packages.${system}.master
            inputs.zigls.packages.${system}.default
          ];
          buildInputs = with pkgs; [ pkg-config ];

          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ ];
          shellHook = "";
        };
      });
}
