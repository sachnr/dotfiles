{ pkgs }: {
  colors = {
    primary = {
      background = "#0a0a0a";
      background2 = "#1e2124";
      background3 = "#3c4048";
      accent = "#ff5ef1";
      foreground = "#ffffff";
      selection = "#3c4048";
    };
    normal = {
      black = "#16181a";
      red = "#ff6e5e";
      orange = "#f8b65e";
      green = "#5eff6c";
      yellow = "#f1ff5e";
      blue = "#5ea1ff";
      purple = "#ff5ef1";
      cyan = "#5ef1ff";
      gray = "#3C4048";
    };
    bright = {
      black = "#3c4048";
      red = "#ff6e5e";
      orange = "#f8b65e";
      green = "#5eff6c";
      yellow = "#f1ff5e";
      blue = "#5ea1ff";
      purple = "#ff5ef1";
      cyan = "#5ef1ff";
      gray = "#ffffff";
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
    font = "Inter Display";
    fontmonospace = "Iosevka";
  };
}
