{theme}:
with theme.colors; ''
  [module/volume]
  type = internal/pulseaudio
  use-ui-max = true
  interval = 5

  format-volume = <ramp-volume><label-volume>

  format-muted = <label-muted>
  format-muted-prefix = " "
  format-muted-prefix-font = 2
  format-muted-prefix-foreground = ${brightred}
  format-muted-prefix-background = ${background}

  label-volume = "%percentage%% "
  label-muted = "Mute"
  format-muted-font = 0

  label-volume-background = ${background}
  label-muted-background = ${background}

  label-volume-foreground = ${foreground}
  label-muted-foreground = ${foreground}

  ramp-volume-0 = "  "
  ramp-volume-1 = "  "
  ramp-volume-2 = "  "
  ramp-volume-3 = "  "
  ramp-volume-4 = "  "
  ramp-volume-5 = "  "
  ramp-volume-6 = "  "
  ramp-volume-7 = "  "
  ramp-volume-8 = "  "
  ramp-volume-9 = "  "
  ramp-volume-font = 2
  ramp-volume-foreground = ${brightblue}
  ramp-volume-background = ${background}

  ramp-headphones-0 = 󰟎
  ramp-headphones-1 = 󰋋
  ramp-headphones-font = 2

  [module/i3]
  type = internal/i3
  pin-workspaces = true
  show-urgent = true
  strip-wsnumbers = false
  index-sort = true
  enable-click = true
  enable-scroll = true
  wrapping-scroll = false
  reverse-scroll = false
  ;    ────────────────────────────────────────────────────────────*/
  format-padding = 1
  ws-icon-0 = 1;
  ws-icon-1 = 2;
  ws-icon-2 = 3;
  ws-icon-3 = 4;
  ws-icon-4 = 5;
  ws-icon-5 = 6;
  ws-icon-6 = 7;
  ws-icon-7 = 8;
  ws-icon-8 = 9;
  ws-icon-9 = 10;
  ws-icon-default = 
  ;    ────────────────────────────────────────────────────────────*/
  format = <label-state> <label-mode>

  label-focused = %icon%
  label-focused-foreground = ${blue}
  label-focused-background = ${background}
  label-focused-underline = ${blue}
  label-focused-padding = 1
  label-focused-font = 1

  label-unfocused = %icon%
  label-unfocused-foreground = ${gray}
  label-unfocused-background = ${background}
  label-unfocused-underline = ${background}
  label-unfocused-padding = 1
  label-unfocused-font = 0

  label-visible = %icon%
  label-visible-padding = 1
  label-visible-font = 0

  label-mode = %index% %mode%
  label-mode-padding = 1
  label-mode-background = ${brightaqua}
  label-mode-font = 1

  label-urgent = %icon%
  label-urgent-foreground = ${black}
  label-urgent-background = ${red}
  label-urgent-padding = 1
  label-urgent-font = 1

  ; Separator in between workspaces
  label-separator = " "
  label-separator-padding = 0
  label-separator-foreground = ${background}
  label-separator-background = ${background}

  [module/time]
  type = internal/date
  interval = 1
  format-margin = 0
  time = "%I:%M %p"
  time-alt = "%A, %m/%d/%y"
  format-prefix = " "
  format-prefix-font = 2
  format-prefix-foreground = ${brightblue}
  format-prefix-background = ${background}
  label = %time%
  label-font = 0
  label-foreground = ${foreground}
  label-background = ${background}
  label-padding = 1

  [module/date]
  type = internal/date
  radius = 6
  interval = 1
  format-margin = 0
  time = "%A, %d"
  time-alt = "%A, %e %b %Y"
  format-prefix = 
  format-prefix-font = 2
  format-prefix-foreground = ${brightblue}
  format-prefix-background = ${background}
  label = %time%
  label-font = 0
  label-foreground = ${foreground}
  label-background = ${background}
  label-padding = 1

  [module/launcher]
  type=custom/text
  content = 
  content-font = 2
  content-foreground= ${blue}
  content-background = ${background}
  content-padding = 1
  click-left= eww open --toggle dashboard

  [module/spacing]
  type = custom/text
  content = " "
  content-background = ${background}
''
