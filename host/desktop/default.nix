{
  nixpkgs,
  home-manager,
  nur,
  overlays,
  inputs,
}: let

  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    inherit overlays;
    config = {
      # packageOverrides = super: {
      # };
      allowUnfree = true; # Allow proprietary software
    };
  };

  inherit (nixpkgs) lib;

  user = "sachnr";

  theme = import ../../theme {};
in
  lib.nixosSystem {
    inherit system pkgs;
    modules = [
      nur.nixosModules.nur
      ./configuration.nix
      ./fontconfig.nix
      ../../extra-settings.nix

      # wallpapers.homeManagerModules.default

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ../../home-manager/users/sachnr;
          extraSpecialArgs = {inherit inputs pkgs system user theme;};
        };
      }
    ];
  }
