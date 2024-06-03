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
      background = "#1E1E2E";
      background2 = bright background "6%";
      background3 = bright background "10%";
      accent = "#89B4FA";
      foreground = "#CDD6F4";
      selection = "#45475a";
    };
    normal = {
      black = "#45475A";
      red = "#F38BA8";
      orange = "#fab387";
      green = "#A6E3A1";
      yellow = "#F9E2AF";
      blue = "#89B4FA";
      purple = "#F5C2E7";
      cyan = "#94E2D5";
      gray = "#BAC2DE";
    };
    bright = {
      black = "#585B70";
      red = "#F38BA8";
      orange = "#fab387";
      green = "#A6E3A1";
      yellow = "#F9E2AF";
      blue = "#89B4FA";
      purple = "#F5C2E7";
      cyan = "#94E2D5";
      gray = "#A6ADC8";
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/Gingeh/wallpapers/main/os/nix-black-4k.png";
    sha256 = "1ygn07s89qxlyjcigfx2jflzxrr6mw89n66qvz38j1hkk1vl2m3v";
  };

  settings = {
    gtk = "numix";
    qt-style = "Adwaita-Dark";
    icon = "icons_papirus";
    font = "Iosevka";
    fontmonospace = "Iosevka";
  };
}
