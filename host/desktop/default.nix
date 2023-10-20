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
      fonts
      inputs.nur.nixosModules.nur
      inputs.home-manager.nixosModules.home-manager

      {
        services.xserver.windowManager.awesome = {
          enable = true;
          luaModules = with pkgs.luajitPackages; [
            luarocks
            lgi
          ];
        };

        programs.hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${system}.hyprland;
          enableNvidiaPatches = true;
          xwayland.enable = true;
        };

        virtualisation.docker.enable = true;

        programs.zsh.enable = true;
        users.users.${user} = {
          isNormalUser = true;
          extraGroups = ["wheel" "video" "audio" "users" "docker"];
          shell = pkgs.zsh;
        };

        users.extraGroups.docker.members = [user];

        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          users.${user} = import ./home.nix;
          extraSpecialArgs = {inherit inputs pkgs system user theme;};
        };
      }
    ];
  }
