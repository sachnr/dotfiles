{lib, ...}: let
  # returns list of all folders in path
  getDirfolders = path: (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name)) (lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path)));
  shell = getDirfolders ../../modules/shell;
  desktop = getDirfolders ../../modules/desktop;
  programs = getDirfolders ../../modules/programs;
  services = getDirfolders ../../modules/services;
in {
  imports =
    [
      ./home.nix
    ]
    ++ desktop
    ++ programs
    ++ services
    ++ shell;

  config.modules = {
    programs = {
      neovim.enable = true;
    };
    shell = {
      zsh.enable = true;
      starship.enable = true;
    };
  };
}
