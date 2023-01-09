{
  nixpkgs,
  home-manager,
  nur,
  overlays,
  hyprland,
  inputs,
}: let
  system = "x86_64-linux"; # System architecture

  pkgs = import nixpkgs {
    inherit system;
    inherit overlays;
    config = {
      allowUnfree = true; # Allow proprietary software
    };
  };

  inherit (nixpkgs) lib;

  user = "sachnr";

  hyprlandpkg = (hyprland.packages.${pkgs.hostPlatform.system}.default.overrideAttrs
    (prevAttrs: rec {
      postInstall = let
        Session = ''
          [Desktop Entry]
          Name=Hyprland
          Comment=An intelligent dynamic tiling Wayland compositor
          Exec=hyprlandwrapped
          Type=Application
        '';
      in ''
        mkdir -p $out/share/wayland-sessions
        echo "${Session}" > $out/share/wayland-sessions/hyprland.desktop
      '';
    }))
  .override {nvidiaPatches = true;};
in
  lib.nixosSystem {
    inherit system pkgs;
    modules = [
      nur.nixosModules.nur
      ./configuration.nix
      ../../extra-settings.nix

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ../../home-manager/users/sachnr;
          extraSpecialArgs = {inherit inputs pkgs system user hyprlandpkg;};
        };
      }
      hyprland.nixosModules.default
      {
        programs.hyprland = {
          enable = true;
          package = hyprlandpkg;
        };
      }
    ];
  }
