{ theme, dpi }:
with theme.colors; ''
  Xft.dpi: ${dpi}
  Xft.antialias: 1
  Xft.hinting: 1
  Xft.autohint: 0
  Xft.hintstyle: hintslight
  Xft.rgba:	none
  Xft.lcdfilter: none

  XTerm*utf8Title: true
  XTerm*utf8: always
  XTerm*renderFont: true
  XTerm*faceName: Iosevka NF
  XTerm*faceSize1: 8
  XTerm*faceSize2: 9
  XTerm*faceSize3: 10
  XTerm*faceSize: 11
  XTerm*faceSize4: 13
  XTerm*faceSize5: 15
  XTerm*faceSize6: 17

  xterm*VT100.Translations: #override \
   Ctrl Shift <Key>v: insert-selection(CLIPBOARD) \n\
   Ctrl Shift <Key>c: copy-selection(CLIPBOARD) \n\
   Ctrl Shift <Key>minus: smaller-vt-font() \n\
   Ctrl Shift <Key>equal: larger-vt-font()

  st.font: fixed:pixelsize=16

  ! window padding
  st.borderpx: 10

  !- 0.1 to 0.9 = transparency
  st.alpha: 1


  *background: ${primary.background}
  *foreground: ${primary.foreground}

  ! Black + DarkGrey
  *color0:  ${normal.black}
  *color8:  ${bright.black}

  ! DarkRed + Red
  *color1:  ${normal.red}
  *color9:  ${bright.red}

  ! DarkGreen + Green
  *color2:  ${normal.green}
  *color10: ${bright.green}

  ! DarkYellow + Yellow
  *color3:  ${normal.yellow}
  *color11: ${bright.yellow}

  ! DarkBlue + Blue
  *color4:  ${normal.blue}
  *color12: ${bright.blue}

  ! DarkMagenta + Magenta
  *color5:  ${normal.purple}
  *color13: ${bright.purple}

  ! DarkCyan + Cyan
  *color6:  ${normal.cyan}
  *color14: ${bright.cyan}

  ! LightGrey + White
  *color7:  ${normal.gray}
  *color15: ${bright.gray}
''
