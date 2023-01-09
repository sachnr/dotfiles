{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-22.11";

    nur = {
      url = "github:nix-community/NUR"; # NUR Packages
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland.url = "github:nix-community/nixpkgs-wayland";
  };

  outputs = inputs @ {self, ...}: let
    overlays = with inputs; [
      nur.overlay
      nixpkgs-wayland.overlay
    ];
  in {
    nixosConfigurations = with inputs; {
      desktop = import ./host/desktop {
        inherit nixpkgs home-manager nur overlays hyprland inputs;
      };
    };
  };
}
