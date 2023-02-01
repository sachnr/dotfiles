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

      *background: ${base00}
      *foreground: ${xcolor15}

      ! Black + DarkGrey
      *color0:  ${xcolor0}
      *color8:  ${xcolor8}

      ! DarkRed + Red
      *color1:  ${xcolor1}
      *color9:  ${xcolor9}

      ! DarkGreen + Green
      *color2:  ${xcolor2}
      *color10: ${xcolor10}

      ! DarkYellow + Yellow
      *color3:  ${xcolor3}
      *color11: ${xcolor11}

      ! DarkBlue + Blue
      *color4:  ${xcolor4}
      *color12: ${xcolor12}

      ! DarkMagenta + Magenta
      *color5:  ${xcolor5}
      *color13: ${xcolor13}

      ! DarkCyan + Cyan
      *color6:  ${xcolor6}
      *color14: ${xcolor14}

      ! LightGrey + White
      *color7:  ${xcolor7}
      *color15: ${xcolor15}
    '';
  };
}
