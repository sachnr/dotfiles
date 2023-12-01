{
  accent = "#688b89";
  background = "#152528";
  background2 = "#282a30";
  background3 = "#2F3239";
  foreground = "#e6eaea";
  selection = "#425e5e";
  black = "#0f1c1e";
  red = "#e85c51";
  orange = "#d96f3e";
  green = "#688b89";
  yellow = "#d78b6c";
  blue = "#5a93aa";
  purple = "#934e69";
  aqua = "#89aeb8";
  gray = "#c8c8c8";
  brightblack = "#4e5157";
  brightred = "#eb746b";
  brightorange = "#ffa066";
  brightgreen = "#8eb2af";
  brightyellow = "#fdb292";
  brightblue = "#73a3b7";
  brightpurple = "#b97490";
  brightaqua = "#afd4de";
  brightgray = "#eeeeee";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-nineish-solarized-dark.png";
    sha256 = "1aiqrs6f8h9dzxidyl302n8rph515y5fsarv3wwcdgna5kvf86k4";
  };
  settings = {
    gtk = "numix"; # name of the gtk theme
    qt-style = "Adwaita-Dark"; # name of qt style in qt5ct
    icon = "icons_papirus"; # name of iconpack
    font = "Iosevka"; # font
    fontmonospace = "Iosevka"; # Iosevka everywhere
  };
}
