{
  description = "Rust Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = with inputs; [
          (import rust-overlay)
        ];
      };
      toolchain = pkgs.rust-bin.nightly.latest.default.override {
        extensions = ["rust-src" "rust-analyzer" "rustfmt" "clippy"];
        targets = ["wasm32-unknown-unknown"];
      };
    in {
      devShells.default = pkgs.mkShell {
        name = "rust-app";
        buildInputs = with pkgs; [
          openssl
          pkg-config
          toolchain
        ];
        RUST_SRC_PATH = "${toolchain}/lib/rustlib/src/rust/library";
        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [pkgs.openssl];
        shellHook = ''
          rustup override set nightly
        '';
      };
    });
}
