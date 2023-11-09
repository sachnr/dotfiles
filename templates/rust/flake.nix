{
  description = "simple rust webapp";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = with inputs; [
          (import rust-overlay)
        ];
      };
      toolchain = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
    in {
      devShells.default = pkgs.mkShell {
        name = "rust-webapp";
        buildInputs = with pkgs; [
          openssl
          pkg-config
          rust-analyzer-unwrapped
          toolchain
        ];
        RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [pkgs.openssl];
        shellHook = ''
          rustup default nightly
        '';
      };
    });
}
