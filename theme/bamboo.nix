{ pkgs }: {
  colors = {
    primary = {
      background = "#232923";
      background2 = "#2d312c";
      background3 = "#363b35";
      accent = "#81af58";
      foreground = "#ece1c0";
      selection = "#dcbf84";
    };
    normal = {
      black = "#171f17";
      red = "#dc4f62";
      orange = "#ef9946";
      green = "#81af58";
      yellow = "#ceba49";
      blue = "#409cdc";
      purple = "#a09af8";
      cyan = "#68baae";
      gray = "#5a5e5a";
    };
    bright = {
      black = "#383d37";
      red = "#dc4f62";
      orange = "#ef9946";
      green = "#81af58";
      yellow = "#ceba49";
      blue = "#409cdc";
      purple = "#a09af8";
      cyan = "#68baae";
      gray = "#ece1c0";
    };
  };

  wallpaper = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/NixOS/nixos-artwork/refs/heads/master/wallpapers/nix-wallpaper-binary-black.png";
    sha256 = "sha256:0v3111a1ihsh4ajijbjh6y7a8p5cb5g3rdxqjbzx37pn1k9s254s";
  };

  settings = {
    gtk = "numix"; # name of the gtk theme
    qt-style = "Adwaita-Dark"; # name of qt style in qt5ct
    icon = "icons_papirus"; # name of iconpack
    font = "Roboto";
    fontmonospace = "Iosevka";
  };
}
