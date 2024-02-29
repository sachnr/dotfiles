{inputs}: let
  inherit (inputs.nixpkgs) lib;
  system = "x86_64-linux";
  user = "sachnr";
  pkgs = import inputs.nixpkgs {
    inherit system lib;
    overlays = [
      inputs.nix-rice.overlays.default
      inputs.neovim-nightly-overlay.overlay
    ];
    config = {
      allowUnfree = true;
    };
  };
  theme = import ../../theme/kanagawa.nix {inherit pkgs;};
in
  lib.nixosSystem {
    inherit system pkgs;
    modules = [
      inputs.home-manager.nixosModules.home-manager
      inputs.wsl.nixosModules.wsl

      {
        time.timeZone = "Asia/Kolkata";
        i18n.defaultLocale = "en_US.UTF-8";
        system.stateVersion = "24.05";

        users.users.${user} = {
          isNormalUser = true;
          extraGroups = ["wheel" "video" "audio" "users" "docker"];
          shell = pkgs.zsh;
        };

        wsl = {
          enable = true;
          nativeSystemd = true;
          defaultUser = user;
        };

        programs.zsh.enable = true;

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ./home.nix;
          extraSpecialArgs = {inherit inputs pkgs system user theme;};
        };
      }
    ];
  }
