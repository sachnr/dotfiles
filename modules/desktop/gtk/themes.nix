{
  pkgs,
  config,
  lib,
  ...
}: let
  gruvbox-kvantum = pkgs.callPackage ../../../pkgs/gruvbox-kvantum.nix {};
  gruvbox-gtk = pkgs.callPackage ../../../pkgs/gruvbox-gtk.nix {};
  everforest-gtk = pkgs.callPackage ../../../pkgs/everforest-gtk.nix {};
  Kvantum-themes = pkgs.callPackage ../../../pkgs/kvantum-themes.nix {};
in {
  home = {
    packages = with pkgs; [
      gruvbox-gtk
      qogir-theme
      catppuccin-gtk
      everforest-gtk
      libsForQt5.breeze-icons
      papirus-icon-theme
    ];
    # kvantumthemes
    file = {
      ".config/" = {
        source = Kvantum-themes;
        recursive = true;
      };
    };
  };
}
