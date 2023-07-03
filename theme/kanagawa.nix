{
  accent = "#8a9a7b";
  background = "#181617";
  background2 = "#282727";
  background3 = "#393836";
  foreground = "#ebdbb2";
  selection = "#2D4F67";
  black = "#0d0c0c";
  red = "#c4746e";
  orange = "#b6927b";
  green = "#8a9a7b";
  yellow = "#c4b28a";
  blue = "#8ba4b0";
  purple = "#a292a3";
  aqua = "#8ea4a2";
  gray = "#C8C093";
  brightblack = "#a6a69c";
  brightred = "#E46876";
  brightorange = "#b98d7b";
  brightgreen = "#87a987";
  brightyellow = "#E6C384";
  brightblue = "#7FB4CA";
  brightpurple = "#938AA9";
  brightaqua = "#7AA89F";
  brightgray = "#c5c9c5";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/assets/kanagawa.jpg";
    sha256 = "sha256:0vljc2h47jjsxabpjzcw7vaqhvkbrvbg8rzjq1p7ydmb08yc14vy";
  };
  name = {
    theme = "kanagawa";
    gtk = "numix";
    kvantum = "Kvantum";
    qt_style = "Fusion";
    icon = "icons_papirus";
    font = "Roboto";
    fontmonospace = "RobotoMono Nerd Font";
  };
}
