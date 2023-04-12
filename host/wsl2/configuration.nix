{
  lib,
  pkgs,
  config,
  user,
  inputs,
  ...
}:
with lib; {
  imports = [
    inputs.wsl.nixosModules.wsl
  ];

  wsl = {
    enable = true;
    automountPath = "/mnt";
    defaultUser = "sachnr";
    startMenuLaunchers = true;

    # Enable native Docker support
    # docker-native.enable = true;

    # Enable integration with Docker Desktop (needs to be installed)
    # docker-desktop.enable = true;
  };

  # Enable nix flakes
  nix.package = pkgs.nixFlakes;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "users"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  environment = {
    sessionVariables = rec {
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      p7zip
      unrar
      unzip
      exfat
      zip
    ];
  };

  system.stateVersion = "22.11";
}
