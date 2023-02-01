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

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
  };

  outputs = inputs @ {self, ...}: let
    overlays = with inputs; [
      nur.overlay
      nixpkgs-wayland.overlay
      (final: prev: {
        awesome-git = nixpkgs-f2k.packages.x86_64-linux.awesome-git;
        picom-git = nixpkgs-f2k.packages.x86_64-linux.picom-git;
      })
    ];
  in {
    nixosConfigurations = with inputs; {
      desktop = import ./host/desktop {
        inherit nixpkgs home-manager nur overlays hyprland inputs;
      };
    };
  };
}
