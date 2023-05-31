{
  lib,
  ...
}: let
  # returns list of all folders in path
  getDirfolders = path: (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name)) (lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path)));
  shell = getDirfolders ../../../../modules/shell;
  desktop = getDirfolders ../../../../modules/desktop;
  programs = getDirfolders ../../../../modules/programs;
  services = getDirfolders ../../../../modules/services;
in {
  imports =
    [
      ./home.nix
    ]
    ++ desktop
    ++ programs
    ++ services
    ++ shell;

  config.modules = rec {
    desktop = {
      awesome.enable = false;
      i3.enable = false;
      waylandPkgs.enable = false;
      hyprland.enable = false;
      sway.enable = false;
      gtk.enable = false;
    };
    programs = {
      waybar.enable = false;
      neovim.enable = true;
      firefox = {
        enable = false;
        startpage = false;
      };
      kitty.enable = false;
      rofi.enable = false;
      qutebrowser.enable = false;
      zathura.enable = false;
      wezterm.enable = false;
      alacritty.enable = false;
    };
    services = {
      picom.enable = false;
      polybar.enable = false;
      mpd.enable = false;
      gammastep.enable = false;
      eww.enable = false;
      mako.enable = false;
      polkit.enable = false;
      gnupg.enable = false;
      swayidle.enable = false;
    };
    shell = {
      zsh.enable = true;
      starship.enable = true;
    };
  };
}
