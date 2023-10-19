{theme}:
with theme; ''
  Xft.dpi: 96
  Xft.antialias: 1
  Xft.hinting: 1
  Xft.autohint: 0
  Xft.hintstyle: hintslight
  Xft.rgba:	none
  Xft.lcdfilter: none

  XTerm*utf8Title: true
  XTerm*utf8: always
  XTerm*renderFont: true
  XTerm*faceName: JetBrainsMono NF
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
''
