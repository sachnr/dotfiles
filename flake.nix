{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    # home-manager = {
    #   url = "github:nix-community/home-manager";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nur = {
      url = "github:nix-community/NUR"; # NUR Packages
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nix-rice = { url = "github:bertof/nix-rice"; };

    tmux-tpm = {
      url = "github:tmux-plugins/tpm";
      flake = false;
    };

    wsl.url = "github:nix-community/NixOS-WSL";

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";

      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, ... }: {
    nixosConfigurations = {
      desktop = import ./host/desktop { inherit inputs; };
      thinkpad = import ./host/thinkpad { inherit inputs; };
      wsl = import ./host/wsl { inherit inputs; };
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
      zig = {
        path = ./templates/zig;
        description = "zig template";
      };
      python = {
        path = ./templates/python;
        description = "py template";
      };
      ruby = {
        path = ./templates/ruby;
        description = "ruby template";
      };
      shopify = {
        path = ./templates/shopify;
        description = "shopify";
      };
    };
  };
}
