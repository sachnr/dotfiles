{
  theme,
  lib,
}:
with theme; let
  rp = str: lib.strings.removePrefix "#" str;
in ''
  # -*- conf -*-

  font=JetBrainsMono NF:size=13.5
  font-size-adjustment=1
  dpi-aware=yes
  pad=6x6

  [cursor]
  style=block
  # color=<inverse foreground/background>
  blink=no
  beam-thickness=1.5
  # underline-thickness=<font underline thickness>

  [colors]
  alpha=1.0
  background=${rp background}
  foreground=${rp foreground}
  flash=${rp green}
  flash-alpha=0.5

  ## Normal/regular colors (color palette 0-7)
  regular0=${rp black}  # black
  regular1=${rp red}  # red
  regular2=${rp green}  # green
  regular3=${rp yellow}  # yellow
  regular4=${rp blue}  # blue
  regular5=${rp purple}  # magenta
  regular6=${rp aqua}  # cyan
  regular7=${rp gray}  # white

  ## Bright colors (color palette 8-15)
  bright0=${rp brightblack}   # bright black
  bright1=${rp brightred}   # bright red
  bright2=${rp brightgreen}   # bright green
  bright3=${rp brightyellow}   # bright yellow
  bright4=${rp brightblue}   # bright blue
  bright5=${rp brightpurple}   # bright magenta
  bright6=${rp brightaqua}   # bright cyan
  bright7=${rp brightgray}   # bright white

  ## Misc colors
  selection-foreground=${rp gray}
  selection-background=${rp selection}
  urls=${rp green}

  [key-bindings]
  scrollback-up-page=Shift+Page_Up
  scrollback-down-page=Shift+Page_Down
  clipboard-copy=Control+Shift+c XF86Copy
  clipboard-paste=Control+Shift+v XF86Paste
  font-increase=Control+Shift+plus
  font-decrease=Control+Shift+underscore
  alpha-increase=Control+Shift+s
  alpha-decrease=Control+Shift+a
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
