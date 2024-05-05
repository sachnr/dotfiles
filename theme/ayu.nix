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
      background = "#0e1419";
      background2 = bright background "6%";
      background3 = bright background "10%";
      accent = "#FFB454";
      foreground = "#e5e1cf";
      selection = "#243340";
    };
    normal = {
      black = "#0A0E14";
      red = "#ff3333";
      orange = "#FF8F40";
      green = "#b8cc52";
      yellow = "#e6c446";
      blue = "#36a3d9";
      purple = "#f07078";
      cyan = "#95e5cb";
      gray = "#B3B1AD";
    };
    bright = {
      black = "#626A73";
      red = "#ff6565";
      orange = "#FF8F40";
      green = "#e9fe83";
      yellow = "#fff778";
      blue = "#68d4ff";
      purple = "#ffa3aa";
      cyan = "#c7fffc";
      gray = "#e5e1cf";
    };
  };

  wallpaper = builtins.fetchurl {
    url = "https://i.imgur.com/gAIHyZ9.jpeg";
    sha256 = "sha256:09grnmc8mpjpikq1q3zqjmdy0zcp6kkgb53xc42asr926mb0hsj2";
  };

  settings = {
    gtk = "numix";
    qt-style = "Adwaita-Dark";
    icon = "icons_papirus";
    font = "Iosevka";
    fontmonospace = "Iosevka";
  };
}
