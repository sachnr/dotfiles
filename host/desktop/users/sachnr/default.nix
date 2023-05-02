{
  user,
  config,
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
      awesome.enable = true;
      i3.enable = false;
      waylandPkgs.enable = true;
      hyprland.enable = false;
      sway.enable = true;
      gtk.enable = true;
    };
    programs = {
      waybar.enable = true;
      neovim = {
        enable = true;
      };
      firefox = {
        enable = true;
        startpage = true;
      };
      kitty.enable = false;
      rofi.enable = true;
      qutebrowser.enable = true;
      zathura.enable = true;
      wezterm.enable = true;
      alacritty.enable = false;
    };
    services = {
      picom.enable = true;
      polybar.enable = false;
      mpd.enable = true;
      gammastep.enable = false;
      eww.enable = true;
      mako.enable = true;
      polkit.enable = true;
      gnupg.enable = true;
      swayidle.enable = true;
    };
    shell = {
      zsh.enable = true;
      starship.enable = true;
      tmux.enable = true;
    };
  };
}
