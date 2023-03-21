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

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    wallpapers.url = "github:sachnr/asdf";

    hyprland-protocols = {
      url = "github:hyprwm/hyprland-protocols";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };
  };

  outputs = inputs @ {self, ...}: let
    overlays = with inputs; [
      nur.overlay
      nixpkgs-wayland.overlay
      neovim-nightly-overlay.overlay
      nixpkgs-f2k.overlays.compositors
      nixpkgs-f2k.overlays.terminal-emulators
      wallpapers.overlay
      # hyprland.overlays.default
      (final: prev: rec {
        awesome = nixpkgs-f2k.packages.x86_64-linux.awesome-git;
        sway-unwrapped = nixpkgs-wayland.packages.x86_64-linux.sway-unwrapped.override {
          wlroots_0_16 = nixpkgs-wayland.packages.x86_64-linux.wlroots.overrideAttrs (_: {
            patches = (prev.patches or []) ++ [./patches/nvidia.patch];
            postPatch = (prev.postPatch or "") + ''substituteInPlace render/gles2/renderer.c --replace "glFlush();" "glFinish();" '';
          });
        };
      })
    ];
  in {
    nixosConfigurations = with inputs; {
      desktop = import ./host/desktop {
        inherit nixpkgs home-manager nur overlays inputs;
      };
    };
  };
}
