_: {
  base00 = "#2b3339";
  base01 = "#323c41";
  base02 = "#3a4248";
  base03 = "#424a50";
  base04 = "#4a5258";
  base05 = "#d3c6aa";
  base06 = "#ddd0b4";
  base07 = "#e7dabe";
  base08 = "#7fbbb3";
  base09 = "#d699b6";
  base0A = "#83c092";
  base0B = "#dbbc7f";
  base0C = "#e69875";
  base0D = "#a7c080";
  base0E = "#e67e80";
  base0F = "#d699b6";
  xcolor0 = "#3c474d";
  xcolor8 = "#868d80";
  xcolor1 = "#e67e80";
  xcolor9 = "#e88a8c";
  xcolor2 = "#a7c080";
  xcolor10 = "#afc68c";
  xcolor3 = "#d9bb80";
  xcolor11 = "#dcc18c";
  xcolor4 = "#7393b3";
  xcolor12 = "#83b6af";
  xcolor5 = "#d39bb6";
  xcolor13 = "#d7a5bd";
  xcolor6 = "#87c095";
  xcolor14 = "#93c69f";
  xcolor7 = "#656d73";
  xcolor15 = "#ddd0b4";
  transparent = "#00000000";

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
