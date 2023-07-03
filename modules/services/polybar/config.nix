{theme}:
with theme; ''
  [global/wm]
  margin-bottom = 0
  margin-top = 0

  [bar/main]
  monitor = "HDMI-0"
  monitor-fallback = "DP-1"
  monitor-strict = false
  override-redirect = false
  bottom = false
  fixed-center = true
  width = 100%
  height = 24
  offset-x = 0
  offset-y = 0
  background = ${black}
  foreground = ${foreground}
  border-size = 0
  border-color = ${background}
  border-bottom-size = 0
  border-bottom-color = ${background}
  border-top-size = 0
  border-top-color = ${background}
  border-left-size = 0
  border-left-color = ${background}
  border-right-size = 0
  border-right-color = ${background}
  separator = "|"
  separator-color = ${gray}
  padding-left = 2
  padding-right = 2
  module-margin-left = 2
  module-margin-right = 2

  ;    ────────────────────────────────────────────────────────────*/

  font-0 = "Roboto:style=Medium:size=10:1"
  font-1 = "Roboto:style=Bold:size=10;1"
  font-2 = "Symbols Nerd Font Mono:size=11;1"

  ;    ────────────────────────────────────────────────────────────*/

  modules-left = i3
  modules-center =
  modules-right = volume time date launcher

  ;    ────────────────────────────────────────────────────────────*/

  spacing = 0
  dim-value = 1.0
  wm-name = i3
  tray-position = center
  tray-maxsize = 16
  tray-background = ${background}
  tray-foreground = ${foreground}
  tray-padding = 0
  dpi-x = 96
  dpi-y = 96
  enable-ipc = false
  click-left =
  click-middle =
  click-right =
  scroll-up = "#i3.prev"
  scroll-down = "#i3.next"
  double-click-left =
  double-click-middle =
  double-click-right =
  cursor-click =
  cursor-scroll =

  [settings]
  screenchange-reload = true
  compositing-background = source
  compositing-foreground = over
  compositing-overline = over
  compositing-underline = over
  compositing-border = over
  format-foreground =
  format-background =
  format-underline =
  format-overline =
  format-spacing =
  format-padding =
  format-margin =
  format-offset =
''
