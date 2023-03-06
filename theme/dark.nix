_: {
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
    url = "https://raw.githubusercontent.com/sachnr/wallpapers/main/wallpapers/minimalistic/black-minimalism-wallpapers.jpg";
    sha256 = "05d6kimpqvflvmbvn9nm037931q0amv4mwwhvmn4zv9lnwr3k1hx";
  };
  name = {
    gtk = "Plata-Noir-Compact";
    kvantum = "Win10OS-dark";
    icon = "Tokyonight-Moon";
    font = "Roboto";
    fontmonospace = "RobotoMono Nerd Font";
  };
}
