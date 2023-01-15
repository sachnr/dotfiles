{
  user,
  config,
  lib,
  ...
}: let
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
    desktop = {
      x11.enable = true;
      hyprland.enable = true;
      gtk.enable = true;
    };
    programs = {
      neovim = {
        enable = true;
      };
      firefox = {
        enable = true;
        startpage = true;
      };
      kitty.enable = true;
      rofi.enable = true;
      qutebrowser.enable = true;
    };
    services = {
      mpd.enable = true;
      gammastep.enable = true;
      eww.enable = true;
      mako.enable = true;
      polkit.enable = true;
      gnupg.enable = true;
      swayidle.enable = true;
    };
    shell = {
      zsh.enable = true;
    };
  };
}
