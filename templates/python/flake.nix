{
  description = "Python Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    mach-nix.url = "github:DavHau/mach-nix";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs { inherit system; };
        py-deps = inputs.mach-nix.lib."${system}".mkPython {
          # requirements = builtins.readFile ./requirements.txt;
          requirements = ''
            numpy
            python-lsp-server
          '';
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "pyenv";
          buildInputs = with pkgs; [
            # pkg-config
            python311
            py-deps
          ];
        };
      });
}
