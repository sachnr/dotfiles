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
      background = "#191724";
      background2 = bright background "6%";
      background3 = bright background "10%";
      accent = "#ebbcba";
      foreground = "#e0def4";
      selection = "#403d52";
    };
    normal = {
      black = "#16141f";
      red = "#eb6f92";
      orange = "#ebbcba";
      green = "#ABE9B3";
      yellow = "#f6c177";
      blue = "#8bbec7";
      purple = "#bb9ede";
      cyan = "#9ccfd8";
      gray = "#6e6a86";
    };
    bright = {
      black = "#908caa";
      red = "#eb6f92";
      orange = "#ebbcba";
      green = "#ABE9B3";
      yellow = "#f6c177";
      blue = "#8bbec7";
      purple = "#c4a7e7";
      cyan = "#a3d6df";
      gray = "#e0def4";
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/sachnr/wallpapers/main/wallpapers/purple/350066.jpg";
    sha256 = "0mxq7pv4623zmjiyzp78yp6in5pvpk2j5div3g2s4r5r5byl3qfj";
  };

  settings = {
    gtk = "numix";
    qt-style = "Adwaita-Dark";
    icon = "icons_papirus";
    font = "Iosevka";
    fontmonospace = "Iosevka";
  };
}
