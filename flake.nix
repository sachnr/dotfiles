{
  description = "A very basic flake";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    # home-manager = {
    #   url = "github:nix-community/home-manager/release-23.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR"; # NUR Packages
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nix-rice = {url = "github:bertof/nix-rice";};

    tmux-tpm = {
      url = "github:tmux-plugins/tpm";
      flake = false;
    };
  };

  outputs = inputs @ {self, ...}: {
    nixosConfigurations = {
      desktop = import ./host/desktop {
        inherit inputs;
      };
    };

    templates = {
      rust = {
        path = ./templates/rust;
        description = "Rust template";
      };
      c = {
        path = ./templates/c;
        description = "c template";
      };
    };
  };
}
