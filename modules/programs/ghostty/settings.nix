{ theme, lib }:
with theme.colors; ''
  # NEW
  adjust-cell-height = 10%
  bold-is-bright = true

  background-opacity = 1.0
  clipboard-paste-protection = false
  clipboard-read = "allow"      

  cursor-invert-fg-bg = true
  cursor-style = "block" 
  cursor-style-blink = false

  gtk-titlebar = false
  gtk-wide-tabs = false

  mouse-hide-while-typing = true

  shell-integration = ssh-env 
  window-decoration = false
  window-inherit-working-directory = false
  window-padding-x = 4
  window-padding-y = 4
  window-theme = "system"

  freetype-load-flags = no-hinting,no-force-autohint,no-monochrome 
  gtk-custom-css = ./tab-style.css
  working-directory = "home"

  # shaders ---------------------------
  custom-shader = ./bloom.glsl
  custom-shader = ./cursor_blaze_no_trail.glsl
  custom-shader = ./cursor_smear.glsl

  # fonts -----------------------------
  font-family = ${theme.settings.fontmonospace}
  font-size = 14.5           
  font-style = ${theme.settings.fontmonospace}
  font-style-bold = ${theme.settings.fontmonospace} Bold
  font-style-bold-italic = ${theme.settings.fontmonospace} Bold Italic
  font-style-italic = ${theme.settings.fontmonospace} Italic

  # Theme colors -------------------------------------------------------------
  cursor-color = ${primary.foreground}
  cursor-text = ${primary.background}
  foreground = ${primary.foreground}
  background = ${primary.background}
  selection-foreground = ${bright.gray} 
  selection-background = ${primary.selection}

  # Palette 0-7 (normal)
  palette = 0=${normal.black}
  palette = 1=${normal.red}
  palette = 2=${normal.green}
  palette = 3=${normal.yellow}
  palette = 4=${normal.blue}
  palette = 5=${normal.purple}
  palette = 6=${normal.cyan}
  palette = 7=${normal.gray}

  # Palette 8-15 (bright)
  palette = 8=${bright.black}
  palette = 9=${bright.red}
  palette = 10=${bright.green}
  palette = 11=${bright.yellow}
  palette = 12=${bright.blue}
  palette = 13=${bright.purple}
  palette = 14=${bright.cyan}
  palette = 15=${bright.gray}
''
