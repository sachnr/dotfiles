{inputs}: let
  inherit (inputs.nixpkgs) lib;
  system = "x86_64-linux";
  user = "sachnr";
  theme = import ../../theme/kanagawa.nix;
  pkgs = import inputs.nixpkgs {
    inherit system lib;
    overlays = import ./overlays.nix {inherit inputs;};
    config = {
      allowBroken = false;
      packageOverrides = super: {
        #
      };
      allowUnfree = true; # Allow proprietary software
    };
  };

  fonts = import ./fonts.nix {inherit theme lib pkgs;};
in
  lib.nixosSystem {
    inherit system pkgs;
    modules = [
      ./configuration.nix
      ./packages.nix
      fonts
      inputs.nur.nixosModules.nur
      inputs.home-manager.nixosModules.home-manager
      {
        virtualisation.docker.enable = true;

        users.users.${user} = {
          isNormalUser = true;
          extraGroups = ["wheel" "video" "audio" "users" "docker"];
          shell = pkgs.zsh;
        };

        users.extraGroups.docker.members = [user];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ./home/modules.nix;
          extraSpecialArgs = {inherit inputs pkgs system user theme;};
        };
      }
    ];
  }
