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
      outer_color = rgb(${rp theme.colors.primary.foreground})
      inner_color =  rgb(${rp theme.colors.primary.background2}})
      font_color = rgb(${rp theme.colors.primary.background})
      fade_on_empty = true
      fade_timeout = 1000 
      placeholder_text = <i>Input Password...</i> 
      hide_input = false
      rounding = -1 
      capslock_color = rgb(${rp theme.colors.normal.yellow})
      check_color = rgb(${rp theme.colors.normal.green})
      fail_color = rgb(${rp theme.colors.normal.red})
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
      color = rgb(${rp theme.colors.primary.foreground})
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
      color = rgb(${theme.colors.primary.foreground})
      font_size = 20
      font_family = ${theme.settings.font}
      position = -100, 160
      halign = right
      valign = bottom
      shadow_passes = 5
      shadow_size = 10
  }
''
