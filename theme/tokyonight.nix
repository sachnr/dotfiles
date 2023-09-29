{
  accent = "#bb9af7";
  background = "#1a1b27";
  background2 = "#24283b";
  background3 = "#3b4261";
  foreground = "#c0caf5";
  selection = "#33467c";
  black = "#15161e";
  red = "#f7768e";
  orange = "#db4b4b";
  green = "#9ece6a";
  yellow = "#e0af68";
  blue = "#7aa2f7";
  purple = "#bb9af7";
  aqua = "#7dcfff";
  gray = "#a9b1d6";
  brightblack = "#414868";
  brightred = "#f7768e";
  brightorange = "#ff9e64";
  brightgreen = "#9ece6a";
  brightyellow = "#e0af68";
  brightblue = "#7aa2f7";
  brightpurple = "#bb9af7";
  brightaqua = "#7dcfff";
  brightgray = "#c0caf5";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/wallpapers/main/wallpapers/purple/350066.jpg";
    sha256 = "0mxq7pv4623zmjiyzp78yp6in5pvpk2j5div3g2s4r5r5byl3qfj";
  };
  name = {
    theme = "tokyonight";
    gtk = "numix";
    kvantum = "Kvantum";
    qt_style = "Fusion";
    icon = "icons_papirus";
    font = "Roboto";
    fontmonospace = "RobotoMono Nerd Font";
  };
}
