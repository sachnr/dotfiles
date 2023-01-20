{
  pkgs,
  config,
  lib,
  ...
}: let
  gruvbox-kvantum = pkgs.callPackage ../../../../pkgs/gruvbox-kvantum.nix {};
  gruvbox-gtk = pkgs.callPackage ../../../../pkgs/gruvbox-gtk.nix {};
  Kvantum-themes = pkgs.callPackage ../../../../pkgs/kvantum-themes.nix {};
in {
  home = {
    packages = with pkgs; [
      gruvbox-gtk
      qogir-theme
      catppuccin-gtk
      Kvantum-themes
    ];
  };
}
