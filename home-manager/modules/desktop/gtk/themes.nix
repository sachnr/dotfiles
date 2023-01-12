{
  pkgs,
  config,
  lib,
  ...
}: let
  gruvbox-kvantum = pkgs.callPackage ../../../../pkgs/gruvbox-kvantum.nix {};
  gruvbox-gtk = pkgs.callPackage ../../../../pkgs/gruvbox-gtk.nix {};
in {
  home = {
    packages = with pkgs; [
      gruvbox-gtk
      qogir-theme
    ];
    file = {
      ".config/Kvantum" = {
        source = gruvbox-kvantum;
        recursive = true;
      };
    };
  };
}

