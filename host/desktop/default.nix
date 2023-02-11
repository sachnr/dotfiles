{
  nixpkgs,
  home-manager,
  nur,
  overlays,
  hyprland,
  inputs,
}: let
  system = "x86_64-linux"; # System architecture

  wallpapers = pkgs.callPackage ../../pkgs/wallpapers.nix {};
  swww = pkgs.callPackage ../../pkgs/swww.nix {};

  pkgs = import nixpkgs {
    inherit system;
    inherit overlays;
    config = {
      packageOverrides = super: {
        inherit swww;
        inherit wallpapers;
      };
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

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ../../home-manager/users/sachnr;
          extraSpecialArgs = {inherit inputs pkgs system user hyprland theme;};
        };
      }
    ];
  }
