{
  accent = "#E0828D";
  background = "#1E1D23";
  background2 = "#2E2930";
  background3 = "#29292E";
  foreground = "#DED7D0";
  selection = "#817081";
  black = "#1A191E";
  red = "#E0828D";
  orange = "#E39A65";
  green = "#8CD881";
  yellow = "#EFD472";
  blue = "#568BB4";
  purple = "#BDA9D4";
  aqua = "#7EC49D";
  gray = "#686069";
  brightblack = "#5E6173";
  brightred = "#E0828D";
  brightorange = "#E39A65";
  brightgreen = "#8CD881";
  brightyellow = "#EFD472";
  brightblue = "#6CAEC0";
  brightpurple = "#BDA9D4";
  brightaqua = "#7EC49D";
  brightgray = "#DED7D0";
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
