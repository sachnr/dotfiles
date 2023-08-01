{lib, ...}: let
  # returns list of all folders in path
  get_dir = path: (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name)) (lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path)));
  shell = get_dir ../../../modules/shell;
  desktop = get_dir ../../../modules/desktop;
  programs = get_dir ../../../modules/programs;
  services = get_dir ../../../modules/services;
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
      awesome.enable = true;
      i3.enable = false;
      waylandPkgs.enable = false;
      hyprland.enable = false;
      sway.enable = false;
      gtk.enable = true;
    };
    programs = {
      waybar.enable = false;
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
      gammastep.enable = false;
      eww.enable = false;
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
