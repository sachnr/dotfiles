{
  overlays,
  inputs,
}: let
  inherit (inputs.nixpkgs) lib;
  system = "x86_64-linux"; # System architecture
  user = "sachnr";
  theme = import ../../theme {};
  pkgs = import inputs.nixpkgs {
    inherit system;
    inherit overlays;
    config = {
      # allowBroken = true;
      packageOverrides = super: {
        startpage = pkgs.callPackage ../../configs/startpage {};
      };
      allowUnfree = true; # Allow proprietary software
    };
  };
  configuration = import ./configuration.nix {inherit lib user inputs theme pkgs;};
in
  lib.nixosSystem {
    inherit system pkgs;
    modules = [
      configuration
      inputs.nur.nixosModules.nur
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ./user_packages.nix;
          extraSpecialArgs = {inherit inputs pkgs system user theme;};
        };
      }
    ];
  }
