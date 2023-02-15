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

    wallpapers.url = "github:sachnr/wallpapers";

    hyprland-protocols = {
      url = "github:hyprwm/hyprland-protocols";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    xdph = {
      url = "github:hyprwm/xdg-desktop-portal-hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hyprland-protocols.follows = "hyprland-protocols";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      # Pin to a nixpkgs revision that doesn't have NixOS/nixpkgs#208103 yet
      inputs.nixpkgs.url = "github:nixos/nixpkgs?rev=fad51abd42ca17a60fc1d4cb9382e2d79ae31836";
    };
  };

  outputs = inputs @ {self, ...}: let
    overlays = with inputs; [
      nur.overlay
      nixpkgs-wayland.overlay
      neovim-nightly-overlay.overlay
      wallpapers.overlay
      (final: prev: rec {
        awesome-git = nixpkgs-f2k.packages.x86_64-linux.awesome-git;
        picom-git = nixpkgs-f2k.packages.x86_64-linux.picom-git;
        hyprland-git = hyprland.packages.x86_64-linux.default.override {nvidiaPatches = true;};
        xdg-desktop-portal-hyprland = xdph.packages.${prev.system}.default.override {
          hyprland-share-picker = xdph.packages.${prev.system}.hyprland-share-picker.override {inherit hyprland-git;};
        };
        wlroots = prev.wlroots.overrideAttrs (_: {
          patches = (prev.patches or []) ++ [./patches/nvidia.patch];
          postPatch = (prev.postPatch or "") + ''substituteInPlace render/gles2/renderer.c --replace "glFlush();" "glFinish();" '';
        });
      })
    ];
  in {
    nixosConfigurations = with inputs; {
      desktop = import ./host/desktop {
        inherit nixpkgs home-manager nur overlays hyprland inputs wallpapers;
      };
    };
  };
}
