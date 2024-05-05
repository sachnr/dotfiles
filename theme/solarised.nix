{ pkgs }:
let
  hexToRgba = pkgs.lib.nix-rice.color.hexToRgba;
  toRGBHex = pkgs.lib.nix-rice.color.toRGBHex;
  brighten = pkgs.lib.nix-rice.color.brighten;
  # darken = pkgs.lib.nix-rice.color.darken;
  # dark = hex: percent: toRGBHex (darken percent (hexToRgba hex));
  bright = hex: percent: toRGBHex (brighten percent (hexToRgba hex));
in {
  colors = {
    primary = rec {
      background = "#152528";
      background2 = bright background "6%";
      background3 = bright background "10%";
      accent = "#688b89";
      foreground = "#e6eaea";
      selection = "#425e5e";
    };
    normal = {
      black = "#0f1c1e";
      red = "#e85c51";
      orange = "#d96f3e";
      green = "#688b89";
      yellow = "#d78b6c";
      blue = "#5a93aa";
      purple = "#934e69";
      cyan = "#89aeb8";
      gray = "#c8c8c8";
    };
    bright = {
      black = "#4e5157";
      red = "#eb746b";
      orange = "#ffa066";
      green = "#8eb2af";
      yellow = "#fdb292";
      blue = "#73a3b7";
      purple = "#b97490";
      cyan = "#afd4de";
      gray = "#eeeeee";
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-nineish-solarized-dark.png";
    sha256 = "1aiqrs6f8h9dzxidyl302n8rph515y5fsarv3wwcdgna5kvf86k4";
  };

  settings = {
    gtk = "numix";
    qt-style = "Adwaita-Dark";
    icon = "icons_papirus";
    font = "Iosevka";
    fontmonospace = "Iosevka";
  };
}
