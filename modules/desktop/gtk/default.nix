{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.desktop.gtk;
  kvtheme = ''
    [General]
    theme=${theme.colors.name.kvantum}
  '';
  qt5ct = ''
    [Appearance]
    color_scheme_path=/home/sachnr/.config/qt5ct/colors/catppuccin.conf
    custom_palette=false
    icon_theme=${theme.colors.name.icon}
    standard_dialogs=default
    style=kvantum

    [Fonts]
    fixed=@Variant(\0\0\0@\0\0\0(\0R\0o\0\x62\0o\0t\0o\0M\0o\0n\0o\0 \0N\0\x65\0r\0\x64\0 \0\x46\0o\0n\0t@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)
    general=@Variant(\0\0\0@\0\0\0\f\0R\0o\0\x62\0o\0t\0o@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)

    [Interface]
    activate_item_on_single_click=1
    buttonbox_layout=0
    cursor_flash_time=1000
    dialog_buttons_have_icons=1
    double_click_interval=400
    gui_effects=@Invalid()
    keyboard_scheme=2
    menus_have_icons=true
    show_shortcuts_in_context_menus=true
    stylesheets=@Invalid()
    toolbutton_style=4
    underline_shortcut=1
    wheel_scroll_lines=3

    [SettingsWindow]
    geometry=@ByteArray(\x1\xd9\xd0\xcb\0\x3\0\0\0\0\0\0\0\0\0\0\0\0\x3\xa9\0\0\x3\xf2\0\0\0\0\0\0\0\0\0\0\x2\xde\0\0\x2\x62\0\0\0\0\x2\0\0\0\a\x80\0\0\0\0\0\0\0\0\0\0\x3\xa9\0\0\x3\xf2)

    [Troubleshooting]
    force_raster_widgets=1
    ignored_applications=@Invalid()
  '';
in
  with lib; {
    options.modules.desktop.gtk = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Gtk + qt config";
      };
    };

    imports = [./themes.nix];

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          libsForQt5.qt5ct
          libsForQt5.qtstyleplugin-kvantum
          gtk3
        ];
        pointerCursor = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors-light";
          size = 32;
          gtk.enable = true;
          x11.enable = true;
          x11.defaultCursor = "phinger-cursors-light";
        };
        sessionVariables = {
          GTK_THEME = "${theme.colors.name.gtk}";
        };
      };

      gtk = with theme.colors; {
        enable = true;
        gtk3.extraConfig = {
          gtk-xft-antialias = 1;
          gtk-xft-hinting = 1;
          gtk-xft-hintstyle = "hintslight";
          gtk-xft-rgba = "rgb";
        };
        font = {
          name = "Roboto";
          size = 10;
        };
        theme.name = name.gtk;
        iconTheme = {
          name = name.icon;
        };
        cursorTheme = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors-light";
          size = 32;
        };
      };
      qt = {
        enable = true;
        platformTheme = null;
        style = {
          package = null;
          name = null;
        };
      };
      home.file.".config/Kvantum/kvantum.kvconfig".text = kvtheme;
      home.file.".config/qt5ct/qt5ct.conf".text = qt5ct;
    };
  }
