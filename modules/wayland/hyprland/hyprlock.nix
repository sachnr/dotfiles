{ theme, lib, ... }:
let rp = str: lib.strings.removePrefix "#" str;
in ''
  background {
      monitor =
      path = $HOME/wallpapers/7 - uieCiSk.jpg
  }

  input-field {
      monitor =
      size = 200, 50
      outline_thickness = 3
      dots_size = 0.33
      dots_spacing = 0.15
      dots_center = true
      dots_rounding = -1 
      outer_color = rgba(${rp theme.colors.primary.accent}aa)
      inner_color =  rgba(${rp theme.colors.normal.black}}aa)
      font_color = rgb(${rp theme.colors.primary.foreground})
      fade_on_empty = true
      fade_timeout = 1000 
      placeholder_text = <i>Input Password...</i> 
      hide_input = false
      rounding = -1 
      check_color = rgba(${rp theme.colors.primary.accent}aa)
      fail_color = rgba(${rp theme.colors.normal.red}aa)
      fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i> 
      fail_transition = 300 
      capslock_color = -1
      numlock_color = -1
      bothlock_color = -1 
      invert_numlock = false 
      swap_font_color = false 
      position = 0, -20
      halign = center
      valign = center
  }

  label {
      monitor =
      text = cmd[update:1000] echo "$TIME"
      color = rgba(${rp theme.colors.primary.foreground}aa)
      font_size = 55
      font_family = ${theme.settings.font}
      position = -100, 70
      halign = right
      valign = bottom
      shadow_passes = 5
      shadow_size = 10
  }

  label {
      monitor =
      text = $USER
      color = rgba(${theme.colors.primary.foreground}aa)
      font_size = 20
      font_family = ${theme.settings.font}
      position = -100, 160
      halign = right
      valign = bottom
      shadow_passes = 5
      shadow_size = 10
  }

  image {
      monitor =
      path = ${theme.wallpaper}
      size = 280 
      rounding = -1 
      border_size = 4
      border_color = rgba(${theme.colors.primary.accent}aa)
      rotate = 0 
      reload_time = -1 
      position = 0, 200
      halign = center
      valign = center
  }
''
