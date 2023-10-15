{
  lib,
  pkgs,
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

  programs.zsh.enable = true;

  environment = {
    sessionVariables = {
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
