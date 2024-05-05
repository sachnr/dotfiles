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
      background = "#181616";
      background2 = bright background "6%";
      background3 = bright background "10%";
      foreground = "#dcd7ba";
      accent = "#8a9a7b";
      selection = "#2D4F67";
    };
    normal = {
      black = "#090618";
      red = "#c34043";
      green = "#76946a";
      yellow = "#c0a36e";
      blue = "#7e9cd8";
      purple = "#957fb8";
      cyan = "#6a9589";
      gray = "#c8c093";
    };
    bright = {
      black = "#727169";
      red = "#e82424";
      orange = "#ffa066";
      green = "#98bb6c";
      yellow = "#e6c384";
      blue = "#7fb4ca";
      purple = "#938aa9";
      cyan = "#7aa89f";
      gray = "#dcd7ba";
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/assets/kanagawa.jpg";
    sha256 = "sha256:0vljc2h47jjsxabpjzcw7vaqhvkbrvbg8rzjq1p7ydmb08yc14vy";
  };

  settings = {
    gtk = "numix"; 
    qt-style = "Adwaita-Dark";
    icon = "icons_papirus";
    font = "Roboto"; 
    fontmonospace = "Iosevka";
  };
}
