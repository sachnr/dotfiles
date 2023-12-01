{
  accent = "#8a9a7b";
  background = "#181616";
  background2 = "#282727";
  background3 = "#393836";
  foreground = "#dcd7ba";
  selection = "#2D4F67";
  black = "#090618";
  red = "#c34043";
  orange = "#ffa066";
  green = "#76946a";
  yellow = "#c0a36e";
  blue = "#7e9cd8";
  purple = "#957fb8";
  aqua = "#6a9589";
  gray = "#c8c093";
  brightblack = "#727169";
  brightred = "#e82424";
  brightorange = "#ffa066";
  brightgreen = "#98bb6c";
  brightyellow = "#e6c384";
  brightblue = "#7fb4ca";
  brightpurple = "#938aa9";
  brightaqua = "#7aa89f";
  brightgray = "#dcd7ba";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/assets/kanagawa.jpg";
    sha256 = "sha256:0vljc2h47jjsxabpjzcw7vaqhvkbrvbg8rzjq1p7ydmb08yc14vy";
  };
  settings = {
    gtk = "numix"; # name of the gtk theme
    qt-style = "Adwaita-Dark"; # name of qt style in qt5ct
    icon = "icons_papirus"; # name of iconpack
    font = "Iosevka"; # font
    fontmonospace = "Iosevka"; # Iosevka everywhere
  };
}
