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

    # hyprland = {
    #   url = "github:vaxerski/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
    };

    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";

    wallpapers.url = "github:sachnr/asdf";

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    nix-rice = {url = "github:bertof/nix-rice";};

    rtl8812au = {
      url = "github:aircrack-ng/rtl8812au";
      flake = false;
    };

    rtl8814au = {
      url = "github:morrownr/8814au";
      flake = false;
    };

    awesomerc = {
      url = "github:sachnr/awesomewm-dotfiles";
      flake = false;
    };

    wsl.url = "github:nix-community/NixOS-WSL";

    tmux-tpm = {
      url = "github:tmux-plugins/tpm";
      flake = false;
    };
  };

  outputs = inputs @ {self, ...}: let
    overlays = with inputs; [
      nur.overlay
      nixpkgs-wayland.overlay
      neovim-nightly-overlay.overlay
      nixpkgs-f2k.overlays.compositors
      wallpapers.overlay
      nix-rice.overlays.default
      # hyprland.overlays.default
      (final: prev: rec {
        awesome = nixpkgs-f2k.packages.x86_64-linux.awesome-luajit-git;
        # sway-unwrapped = nixpkgs-wayland.packages.x86_64-linux.sway-unwrapped.override {
        #   wlroots_0_16 = nixpkgs-wayland.packages.x86_64-linux.wlroots.overrideAttrs (_: {
        #     patches = (prev.patches or []) ++ [./patches/nvidia.patch];
        #     postPatch = (prev.postPatch or "") + ''substituteInPlace render/gles2/renderer.c --replace "glFlush();" "glFinish();" '';
        #   });
        # };
      })
    ];
  in {
    nixosConfigurations = with inputs; {
      desktop = import ./host/desktop {
        inherit overlays inputs;
      };

      wsl2 = import ./host/wsl2 {
        inherit overlays inputs;
      };
    };
  };
}
