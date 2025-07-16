{ pkgs }:
let
  hexToRgba = pkgs.lib.nix-rice.color.hexToRgba;
  toRGBHex = pkgs.lib.nix-rice.color.toRGBHex;
  brighten = pkgs.lib.nix-rice.color.brighten;
  bright = hex: percent: toRGBHex (brighten percent (hexToRgba hex));
in {
  colors = {
    primary = rec {
      background = "#1E1E1E";
      background2 = bright background "6%";
      background3 = bright background "10%";
      accent = "#4C4C4C";
      foreground = "#D4D4D4";
      selection = "#404040";
    };
    normal = {
      black = "#181818";
      red = "#FF5F5F";
      orange = "#B8B8B8";
      green = "#97D59B";
      yellow = "#D7BA7D";
      blue = "#569CD6";
      purple = "#9E9E9E";
      cyan = "#88C0D0";
      gray = "#808080";
    };
    bright = {
      black = "#666666";
      red = "#FF7070";
      orange = "#CCCCCC";
      green = "#A8E4AC";
      yellow = "#E6CB8B";
      blue = "#67ACE6";
      purple = "#AEAEAE";
      cyan = "#98D0E0";
      gray = "#D4D4D4";
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-nineish-solarized-dark.png";
    sha256 = "1aiqrs6f8h9dzxidyl302n8rph515y5fsarv3wwcdgna5kvf86k4";
  };

  settings = {
    gtk = "Graphite-Dark";
    qt-style = "gtk3";
    icon = "Tela-circle";
    font = "Roboto";
    fontmonospace = "Iosevka";
  };
}
