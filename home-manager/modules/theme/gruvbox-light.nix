_: {
  base00 = "#f2e5bc";
  base01 = "#ebdbb2";
  base02 = "#d5c4a1";
  base03 = "#bdae93";
  base04 = "#665c54";
  base05 = "#504945";
  base06 = "#3c3836";
  base07 = "#282828";
  base08 = "#9d0006";
  base09 = "#af3a03";
  base0A = "#b57614";
  base0B = "#79740e";
  base0C = "#427b58";
  base0D = "#076678";
  base0E = "#8f3f71";
  base0F = "#d65d0e";
  xcolor0 = "#fbf1c7";
  xcolor8 = "#928374";
  xcolor1 = "#cc241d";
  xcolor9 = "#9d0006";
  xcolor2 = "#98971a";
  xcolor10 = "#79740e";
  xcolor3 = "#d79921";
  xcolor11 = "#b57614";
  xcolor4 = "#458588";
  xcolor12 = "#076678";
  xcolor5 = "#b16286";
  xcolor13 = "#8f3f71";
  xcolor6 = "#689d6a";
  xcolor14 = "#427b58";
  xcolor7 = "#7c6f64";
  xcolor15 = "#3c3836";
  transparent = "#00000000";
  wallpaper = builtins.fetchurl {
    url = "https://raw.githubusercontent.com/sachnr/awesomewm-dotfiles/master/wallpapers/gruvbox-light.png";
    sha256 = "1m7hhkrcah8s3krmh1zykzsi4wy4hd83ghvy6mwz3vwc7zvcnag8";
  };
  name = {
    gtk = "Gruvbox-Light-B";
    kvantum = "Gruvbox";
    icon = "Papirus-Dark";
    font = "Roboto";
    fontmonospace = "RobotoMono Nerd Font";
  };
}
