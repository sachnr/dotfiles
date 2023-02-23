_: {
  background = "#323c41";
  foreground = "#d8caac";
  selection = "#5a5f5a";
  black = "#2b302b";
  red = "#cc241d";
  green = "#98971a";
  yellow = "#d79921";
  blue = "#458588";
  purple = "#b16286";
  aqua = "#689d6a";
  gray = "#7c6f64";
  brightblack = "#928374";
  brightred = "#f92572";
  brightgreen = "#a6e22e";
  brightyellow = "#f0c674";
  brightblue = "#66d9ef";
  brightpurple = "#ae81ff";
  brightaqua = "#a1efe4";
  brightgray = "#f2e5bc";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/wallpapers/main/green/forest.jpg";
    sha256 = "13h5nmpr6d1yybwsczgmwz39lv6b0jr7ps66vnwp9gff06lxqsw5";
  };
  name = {
    gtk = "Everforest-Dark-B";
    kvantum = "Gruvbox-Dark-Blue";
    icon = "Everforest-Dark";
    font = "Roboto";
    fontmonospace = "RobotoMono Nerd Font";
  };
}
