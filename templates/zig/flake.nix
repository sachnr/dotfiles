{
  description = "Zig Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    zig.url = "github:mitchellh/zig-overlay";
    zigls.url = "github:zigtools/zls";
    langref.url = "https://raw.githubusercontent.com/ziglang/zig/63bd2bff12992aef0ce23ae4b344e9cb5d65f05d/doc/langref.html.in";
    langref.flake = false;
  };

  outputs = inputs @ {self, ...}:
    inputs.flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = with inputs; [
          zig.overlays.default
          (final: prev: {
            zig = inputs.zig.packages.${system}.master;
          })
        ];
      };

      zigls = import ./nix/zigls.nix {inherit pkgs inputs system;};
    in {
      devShells.default = pkgs.mkShell {
        name = "Zig";
        nativeBuildInputs = with pkgs; [
          zigpkgs.master
        ];
        buildInputs = with pkgs; [
          zigls

          # libraries
          pkg-config
        ];

        LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [];
        shellHook = ''
        '';
      };
    });
}
