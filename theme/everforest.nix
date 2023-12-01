{
  accent = "#7FBBB3";
  background = "#272e33";
  background2 = "#2e383c";
  background3 = "#374145";
  foreground = "#D3c6AA";
  selection = "#3C4841";
  black = "#1E2326";
  red = "#e67e80";
  orange = "#e69875";
  green = "#a7c080";
  yellow = "#dbbc7f";
  blue = "#7fbbb3";
  purple = "#d699b6";
  aqua = "#83c092";
  gray = "#7a8478";
  brightblack = "#4b565c";
  brightred = "#e67e80";
  brightorange = "#e69875";
  brightgreen = "#a7c080";
  brightyellow = "#dbbc7f";
  brightblue = "#7fbbb3";
  brightpurple = "#d699b6";
  brightaqua = "#83c092";
  brightgray = "#d3c6aa";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/wallpapers/main/green/forest.jpg";
    sha256 = "13h5nmpr6d1yybwsczgmwz39lv6b0jr7ps66vnwp9gff06lxqsw5";
  };
  settings = {
    gtk = "numix"; # name of the gtk theme
    qt-style = "Adwaita-Dark"; # name of qt style in qt5ct
    icon = "icons_papirus"; # name of iconpack
    font = "Iosevka"; # font
    fontmonospace = "Iosevka"; # Iosevka everywhere
  };
}
