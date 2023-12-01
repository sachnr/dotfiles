{
  theme,
  user,
  pkgs,
  oomox,
}: let
  custom-stylesheet =
    pkgs.writeText "custom.qss"
    ''
      QFrame {
          border: none;
      }
    '';
in ''
  [Appearance]
  color_scheme_path=${oomox}/.config/qt5ct/colors/numix.conf
  custom_palette=true
  icon_theme=icons_papirus
  standard_dialogs=xdgdesktopportal
  style=${theme.settings.qt-style}

  [Fonts]
  fixed="${theme.settings.font},11,-1,5,50,0,0,0,0,0,Medium"
  general="${theme.settings.fontmonospace},11,-1,5,50,0,0,0,0,0,Medium"

  [Interface]
  activate_item_on_single_click=1
  buttonbox_layout=0
  cursor_flash_time=1000
  dialog_buttons_have_icons=2
  double_click_interval=400
  gui_effects=@Invalid()
  keyboard_scheme=2
  menus_have_icons=true
  show_shortcuts_in_context_menus=true
  stylesheets=${custom-stylesheet}
  toolbutton_style=4
  underline_shortcut=1
  wheel_scroll_lines=3

  [SettingsWindow]
  geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\f\0\0\0.\0\0\x3\xb9\0\0\x4+\0\0\0\xe\0\0\0\x30\0\0\x3\xb7\0\0\x4)\0\0\0\0\0\0\0\0\a\x80\0\0\0\xe\0\0\0\x30\0\0\x3\xb7\0\0\x4))

  [Troubleshooting]
  force_raster_widgets=1
  ignored_applications=@Invalid()
''
