{lib, ...}: let
  # returns list of all folders in path
  get_dir = path: (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name)) (lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path)));
  shell = get_dir ../../../modules/shell;
  xorg = get_dir ../../../modules/xorg;
  wayland = get_dir ../../../modules/wayland;
  programs = get_dir ../../../modules/programs;
  services = get_dir ../../../modules/services;
in {
  imports =
    [
      ./home.nix
    ]
    ++ xorg
    ++ wayland
    ++ programs
    ++ services
    ++ shell;

  config.modules = {
    xorg = {
      awesome.enable = true;
      i3.enable = false;
    };
    wayland = {
      hyprland.enable = false;
      sway.enable = false;
      extraPkgs.enable = false;
      mako.enable = false;
      swayidle.enable = false;
      waybar.enable = false;
    };
    programs = {
      gtk.enable = true;
      neovim.enable = true;
      firefox.enable = false;
      kitty.enable = true;
      rofi.enable = true;
      qutebrowser.enable = true;
      zathura.enable = true;
      wezterm.enable = true;
      alacritty.enable = false;
      ugchromium.enable = true;
    };
    services = {
      picom.enable = true;
      polybar.enable = false;
      mpd.enable = true;
      eww.enable = false;
      polkit.enable = true;
      gnupg.enable = true;
    };
    shell = {
      zsh.enable = true;
      starship.enable = true;
      tmux.enable = true;
    };
  };
}
