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
      background = "#1D1D1D";
      background2 = bright background "6%";
      background3 = bright background "10%";
      accent = "#D0A18A"; # mellifluous red/main_keywords
      foreground = "#DEDEDE";
      selection = "#3C3C3C"; # slightly brighter than background3
    };
    normal = {
      black = "#1D1D1D"; # background
      red = "#D0A18A"; # main_keywords
      orange = "#CBD19E"; # other_keywords
      green = "#ACCBA4"; # green
      yellow = "#BCCEA1"; # strings/yellow
      blue = "#BF9AC1"; # functions/blue
      purple = "#BC9FAD"; # constants/purple
      cyan = "#51B937"; # comments (dark_green)
      gray = "#C3C4AB"; # types/khaki
    };
    bright = {
      black = "#626A73"; # dimmed foreground
      red = "#CF5117"; # light variant red
      orange = "#D3EC13"; # light variant orange
      green = "#33BC10"; # light variant green
      yellow = "#9CED21"; # light variant yellow
      blue = "#812D86"; # light variant blue
      purple = "#A32964"; # light variant purple
      cyan = "#74D65C"; # light variant dark_green
      gray = "#DEDEDE"; # foreground
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nix-wallpaper-binary-black.png";
    sha256 = "sha256:0v3111a1ihsh4ajijbjh6y7a8p5cb5g3rdxqjbzx37pn1k9s254s";
  };

  settings = {
    gtk = "numix";
    qt-style = "Adwaita-Dark";
    icon = "icons_papirus";
    font = "IosevkaTerm NF";
    fontmonospace = "IosevkaTerm NF";
  };
}
