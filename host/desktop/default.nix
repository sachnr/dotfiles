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
  theme = import ../../theme/ayu.nix { inherit pkgs; };
  fonts = import ./fonts.nix { inherit theme lib pkgs; };
  dpi = 109;
in lib.nixosSystem {
  inherit system pkgs;
  modules = [
    ./configuration.nix
    fonts
    inputs.nur.nixosModules.nur
    inputs.home-manager.nixosModules.home-manager

    {
      services.xserver.windowManager.awesome = {
        enable = true;
        luaModules = with pkgs.luajitPackages; [ luarocks lgi ];
      };

      services.xserver.desktopManager = { xfce = { enable = true; }; };

      services.desktopManager = { plasma6.enable = false; };

      # environment.systemPackages = with pkgs; [ egl-wayland ];
      # programs.sway = {
      #   enable = true;
      #   wrapperFeatures.gtk = true;
      #   package = pkgs.swayfx;
      # };
      programs.hyprland = { enable = true; };

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };

      # services.emacs.enable = true;

      virtualisation.docker.enable = true;

      programs.zsh.enable = true;
      users.users.${user} = {
        isNormalUser = true;
        extraGroups = [ "wheel" "video" "audio" "users" "docker" "pipewire" ];
        shell = pkgs.zsh;
      };

      users.extraGroups.docker.members = [ user ];

      home-manager = {
        backupFileExtension = "rebuild";
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${user} = import ./home.nix;
        extraSpecialArgs = { inherit inputs pkgs system user theme dpi; };
      };
    }
  ];
}
