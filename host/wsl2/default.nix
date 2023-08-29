{inputs}: let
  inherit (inputs.nixpkgs) lib;
  system = "x86_64-linux"; # System architecture
  user = "sachnr";
  overlays = import ./overlays.nix {inherit inputs;};

  config = {
    allowUnfree = true;
  };

  theme = import ../../theme/kanagawa.nix;
  pkgs = import inputs.nixpkgs {
    inherit config;
    inherit system;
    inherit overlays;
  };
  configuration = import ./configuration.nix {inherit lib config user inputs pkgs;};
in
  lib.nixosSystem {
    inherit system pkgs;
    modules = [
      configuration
      inputs.home-manager.nixosModules.home-manager
      {
        # Define a user account. Don't forget to set a password with ‘passwd’.
        users.users.${user} = {
          isNormalUser = true;
          extraGroups = ["wheel" "video" "audio" "users"]; # Enable ‘sudo’ for the user.
          shell = pkgs.zsh;
        };

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ./user_packages_wsl.nix;
          extraSpecialArgs = {inherit inputs pkgs system user theme;};
        };
      }
    ];
  }
