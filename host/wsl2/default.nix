{
  overlays,
  inputs,
}: let
  inherit (inputs.nixpkgs) lib;
  system = "x86_64-linux"; # System architecture
  user = "sachnr";

  config = {
      allowUnfree = true;
  };

  theme = import ../../theme {};
  pkgs = import inputs.nixpkgs {
    inherit config;
    inherit system;
    inherit overlays;
  };
  configuration = import ./configuration.nix {inherit lib config user inputs pkgs;};
in
  lib.nixosSystem {
    inherit system pkgs;
    modules = [
      configuration
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ./user_packages_wsl.nix;
          extraSpecialArgs = {inherit inputs pkgs system user theme;};
        };
      }
    ];
  }
