{theme, ...}: {
  xresources = with theme.colors; {
    extraConfig = ''
      Xft.dpi: 96
      Xft.antialias: 1
      Xft.hinting: 1
      Xft.autohint: 0
      Xft.hintstyle: hintslight
      Xft.rgba:	rgb
      Xft.lcdfilter: lcddefault

      st.font: JetBrainsMono Nerd Font:style:medium:pixelsize=14

      ! window padding
      st.borderpx: 10

      !- 0.1 to 0.9 = transparency
      st.alpha: 1

      *background: ${background}
      *foreground: ${foreground}

      ! Black + DarkGrey
      *color0:  ${black}
      *color8:  ${brightblack}

      ! DarkRed + Red
      *color1:  ${red}
      *color9:  ${brightred}

      ! DarkGreen + Green
      *color2:  ${green}
      *color10: ${brightgreen}

      ! DarkYellow + Yellow
      *color3:  ${yellow}
      *color11: ${brightyellow}

      ! DarkBlue + Blue
      *color4:  ${blue}
      *color12: ${brightblue}

      ! DarkMagenta + Magenta
      *color5:  ${purple}
      *color13: ${brightpurple}

      ! DarkCyan + Cyan
      *color6:  ${aqua}
      *color14: ${brightaqua}

      ! LightGrey + White
      *color7:  ${gray}
      *color15: ${brightgray}
    '';
  };
}
