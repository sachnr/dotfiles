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
      background = "#282829";
      background2 = bright background "6%";
      background3 = bright background "10%";
      accent = "#83a598";
      foreground = "#ebdbb2";
      selection = "#504945";
    };
    normal = {
      black = "#1d2021";
      red = "#cc241d";
      orange = "#e78a4e";
      green = "#98971a";
      yellow = "#d79921";
      blue = "#458588";
      purple = "#b16286";
      cyan = "#689d6a";
      gray = "#a89984";
    };
    bright = {
      black = "#928374";
      red = "#fb4934";
      orange = "#e78a4e";
      green = "#b8bb26";
      yellow = "#fabd2f";
      blue = "#83a598";
      purple = "#d3869b";
      cyan = "#8ec07c";
      gray = "#ebdbb2";
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/FrenzyExists/wallpapers/main/Gruv/gruv-pixel-III.png";
    sha256 = "sha256:0qb9jydrn9i5mbrzf55hw6h0vlxhmwy2gihp9rdcri3wl4294pp8";
  };

  settings = {
    gtk = "numix"; # name of the gtk theme
    qt-style = "Adwaita-Dark"; # name of qt style in qt5ct
    icon = "icons_papirus"; # name of iconpack
    font = "Iosevka"; 
    fontmonospace = "Iosevka";
  };
}
