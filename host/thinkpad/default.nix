{ inputs }:
let
  inherit (inputs.nixpkgs) lib;
  system = "x86_64-linux";
  user = "sachnr";
  pkgs = import inputs.nixpkgs {
    inherit system lib;
    overlays = import ./overlays.nix { inherit inputs system; };
    config = {
      allowBroken = false;
      packageOverrides = super: { };
      allowUnfree = true;
    };
  };
  theme = import ../../theme/rosepine.nix { inherit pkgs; };
  fonts = import ./fonts.nix { inherit theme lib pkgs; };
  dpi = "96";
in lib.nixosSystem {
  inherit system pkgs;
  modules = [
    ./configuration.nix
    fonts
    inputs.nur.modules.nixos.default
    inputs.home-manager.nixosModules.home-manager

    {
      services.xserver.windowManager.awesome = {
        enable = true;
        package = pkgs.awesome-git;
        luaModules = with pkgs.luajitPackages; [ luarocks lgi luv ];
      };

      virtualisation.docker.enable = true;

      programs.i3lock = {
        enable = true;
        package = pkgs.i3lock-color;
      };

      programs.zsh.enable = true;
      programs.fish.enable = true;
      users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "users" "docker" ];
        shell = pkgs.fish;
      };

      users.extraGroups.docker.members = [ user ];

      services = {
        udisks2.enable = true;
        devmon.enable = true;
      };

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = import ./home.nix;
        extraSpecialArgs = { inherit inputs pkgs system user theme dpi; };
      };
    }
  ];
}
