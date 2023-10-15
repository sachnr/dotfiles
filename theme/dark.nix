{
  accent = "#7E97AB";
  background = "#171717";
  background2 = "#2e2e2e";
  background3 = "#313131";
  foreground = "#D0D0D0";
  selection = "#474747";
  black = "#151515";
  red = "#984936";
  orange = "#FFA557";
  green = "#90A959";
  yellow = "#F4BF75";
  blue = "#7E97AB";
  purple = "#AA749F";
  aqua = "#88afa2";
  gray = "#727272";
  brightblack = "#373737";
  brightred = "#984936";
  brightorange = "#FFA557";
  brightgreen = "#90A959";
  brightyellow = "#e0af68";
  brightblue = "#7E97AB";
  brightpurple = "#AA759F";
  brightaqua = "#88afa2";
  brightgray = "#AFAFAF";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/assets/black-minimal.jpg";
    sha256 = "1zwxmwmw15wjmyw9jjbsph35sypdzb4hddql23kq65v1c60dm9ig";
  };
  name = {
    theme = "dark";
    gtk = "numix";
    kvantum = "Kvantum";
    qt_style = "Fusion";
    icon = "icons_papirus";
    font = "Roboto";
    fontmonospace = "Roboto Mono";
  };
}
