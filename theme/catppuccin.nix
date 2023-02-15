_: {
  base00 = "#181825"; # mantle
  base01 = "#1e1e2e"; # base
  base02 = "#313244"; # surface0
  base03 = "#45475a"; # surface1
  base04 = "#585b70"; # surface2
  base05 = "#cdd6f4"; # text
  base06 = "#f5e0dc"; # rosewater
  base07 = "#b4befe"; # lavender
  base08 = "#f38ba8"; # red
  base09 = "#fab387"; # peach
  base0A = "#f9e2af"; # yellow
  base0B = "#a6e3a1"; # green
  base0C = "#94e2d5"; # teal
  base0D = "#89b4fa"; # blue
  base0E = "#cba6f7"; # mauve
  base0F = "#f2cdcd"; # flamingo
  xcolor0 = "#252434";
  xcolor8 = "#3e3d4d";
  xcolor1 = "#F38BA8";
  xcolor9 = "#eba0ac";
  xcolor2 = "#ABE9B3";
  xcolor10 = "#b6f4be";
  xcolor3 = "#fab387";
  xcolor11 = "#f9e2af";
  xcolor4 = "#89b4fa";
  xcolor12 = "#74c7ec";
  xcolor5 = "#cba6f7";
  xcolor13 = "#d0a9e5";
  xcolor6 = "#94e2d5";
  xcolor14 = "#B5E8E0";
  xcolor7 = "#605f6f";
  xcolor15 = "#cdd6f4";
  transparent = "#00000000";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/wallpapers/main/flatppuccin/flatppuccin_4k_macchiato.png";
    sha256 = "12s7qcf5al14kp9rd0vi8g7bmm2jsawb22rb7ppkapmwv5hb6yl4";
  };
  name = {
    gtk = "Catppuccin-Dark";
    kvantum = "Catppuccin-Mocha-Blue";
    icon = "Papirus-Dark";
    font = "Roboto";
    fontmonospace = "RobotoMono Nerd Font";
  };
}
