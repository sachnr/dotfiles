_: {
  background = "#282829";
  foreground = "#ebdbb2";
  selection = "#504945";
  black = "#1d2021";
  red = "#cc241d";
  green = "#98971a";
  yellow = "#d79921";
  blue = "#458588";
  purple = "#b16286";
  aqua = "#689d6a";
  gray = "#a89984";
  brightblack = "#928374";
  brightred = "#fb4934";
  brightgreen = "#b8bb26";
  brightyellow = "#fabd2f";
  brightblue = "#83a598";
  brightpurple = "#d3869b";
  brightaqua = "#8ec07c";
  brightgray = "#ebdbb2";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/FrenzyExists/wallpapers/main/Gruv/gruv-pixel-III.png";
    sha256 = "sha256:0qb9jydrn9i5mbrzf55hw6h0vlxhmwy2gihp9rdcri3wl4294pp8";
  };
  name = {
    gtk = "Gruvbox-Dark-B";
    kvantum = "Gruvbox-Dark-Blue";
    icon = "Gruvbox-Dark";
    font = "Roboto";
    fontmonospace = "RobotoMono Nerd Font";
  };
}
