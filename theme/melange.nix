{
  accent = "#BD8183";
  background = "#292522";
  background2 = "#2E2827";
  background3 = "#34302C";
  foreground = "#DED7D0";
  selection = "#403A36";
  black = "#34302C";
  red = "#BD8183";
  orange = "#E39A65";
  green = "#78997A";
  yellow = "#E49B5D";
  blue = "#7F91B2";
  purple = "#B380B0";
  aqua = "#7B9695";
  gray = "#C1A78E";
  brightblack = "#867462";
  brightred = "#D47766";
  brightorange = "#E39A65";
  brightgreen = "#85B695";
  brightyellow = "#EBC06D";
  brightblue = "#A3A9CE";
  brightpurple = "#CF9BC2";
  brightaqua = "#89B3B6";
  brightgray = "#ECE1D7";
  wallpaper = builtins.fetchurl {
    url = "https://images.unsplash.com/photo-1465326718387-85450d5f1510";
    sha256 = "sha256:1v946y4wkwqk6s9m0l8jv1ccdzj1vsh86sb3zjjsf463f02qg6l5";
  };
  settings = {
    gtk = "numix"; # name of the gtk theme
    qt-style = "Adwaita-Dark"; # name of qt style in qt5ct
    icon = "icons_papirus"; # name of iconpack
    font = "Iosevka"; # font
    fontmonospace = "Iosevka"; # Iosevka everywhere
  };
}
