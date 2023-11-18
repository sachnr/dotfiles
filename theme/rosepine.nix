{
  accent = "#ebbcba";
  background = "#191724";
  background2 = "#262431";
  background3 = "#353340";
  foreground = "#e0def4";
  selection = "#403d52";
  black = "#16141f";
  red = "#eb6f92";
  orange = "#ebbcba";
  green = "#ABE9B3";
  yellow = "#f6c177";
  blue = "#8bbec7";
  purple = "#bb9ede";
  aqua = "#9ccfd8";
  gray = "#6e6a86";
  brightblack = "#908caa";
  brightred = "#eb6f92";
  brightorange = "#ebbcba";
  brightgreen = "#ABE9B3";
  brightyellow = "#f6c177";
  brightblue = "#8bbec7";
  brightpurple = "#c4a7e7";
  brightaqua = "#a3d6df";
  brightgray = "#e0def4";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/wallpapers/main/wallpapers/purple/350066.jpg";
    sha256 = "0mxq7pv4623zmjiyzp78yp6in5pvpk2j5div3g2s4r5r5byl3qfj";
  };
  name = {
    theme = "rosepine";
    gtk = "numix";
    kvantum = "Kvantum";
    qt_style = "Fusion";
    icon = "icons_papirus";
    font = "Roboto";
    fontmonospace = "Roboto Mono";
  };
}
