{
  theme,
  lib,
}:
with theme.colors; let
  rp = str: lib.strings.removePrefix "#" str;
in ''
  # -*- conf -*-

  font=Iosevka:size=12
  font-size-adjustment=0.5
  dpi-aware=no
  pad=6x6
  underline-offset=2px

  [cursor]
  style=block
  # color=<inverse foreground/background>
  blink=no
  beam-thickness=1.5
  # underline-thickness=<font underline thickness>

  [colors]
  alpha=1.0
  background=${rp primary.background}
  foreground=${rp primary.foreground}
  flash=${rp normal.green}
  flash-alpha=0.5

  ## Normal/regular colors (color palette 0-7)
  regular0=${rp normal.black}  # black
  regular1=${rp normal.red}  # red
  regular2=${rp normal.green}  # green
  regular3=${rp normal.yellow}  # yellow
  regular4=${rp normal.blue}  # blue
  regular5=${rp normal.purple}  # magenta
  regular6=${rp normal.cyan}  # cyan
  regular7=${rp normal.gray}  # white

  ## Bright colors (color palette 8-15)
  bright0=${rp bright.black}   # bright black
  bright1=${rp bright.red}   # bright red
  bright2=${rp bright.green}   # bright green
  bright3=${rp bright.yellow}   # bright yellow
  bright4=${rp bright.blue}   # bright blue
  bright5=${rp bright.purple}   # bright magenta
  bright6=${rp bright.cyan}   # bright cyan
  bright7=${rp bright.gray}   # bright white

  ## Misc colors
  selection-foreground=${rp normal.gray}
  selection-background=${rp primary.selection}
  urls=${rp normal.green}

  [key-bindings]
  scrollback-up-page=Shift+Page_Up
  scrollback-down-page=Shift+Page_Down
  clipboard-copy=Control+Shift+c XF86Copy
  clipboard-paste=Control+Shift+v XF86Paste
  font-increase=Control+Shift+plus
  font-decrease=Control+Shift+underscore
  font-reset=Control+Shift+BackSpace
  primary-paste=none
  search-start=none
  spawn-terminal=none
  pipe-visible=none
  pipe-scrollback=none
  pipe-selected=none
  show-urls-launch=none
  prompt-prev=none
  prompt-next=none
  unicode-input=none

  [text-bindings]
  # \x03=Mod4+c  # Map Super+c -> Ctrl+c
''
