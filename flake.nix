{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # pin older nixpkgs revision that dosent break nvidia drivers
    # NVIDIA-Linux-x86_64-530.41.03
    # kernel 6.3.8
    nixpkgs-old = {
      url = "github:nixos/nixpkgs?rev=b80586e5cfa435e451c368aca4f9fbbaa4f2eaa9";
    };

    nur = {
      url = "github:nix-community/NUR"; # NUR Packages
    };

    # home-manager = {
    #   url = "github:nix-community/home-manager/release-23.05";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # unstable
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    # neovim-nightly-overlay = {
    #   url = "github:nix-community/neovim-nightly-overlay";
    # };

    nix-rice = {url = "github:bertof/nix-rice";};

    wsl.url = "github:nix-community/NixOS-WSL";

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

      wsl2 = import ./host/wsl2 {
        inherit inputs;
      };
    };
  };
}
