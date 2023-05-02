{
  pkgs,
  config,
  lib,
  theme,
  user,
  ...
}: let
  oomox = pkgs.callPackage ../../../pkgs/themix-gui.nix {inherit theme;};
  cfg = config.modules.desktop.gtk;

  kvtheme = ''
    [General]
    theme=${theme.colors.name.kvantum}
  '';

  qt5ct = with theme.colors; ''
    [Appearance]
    color_scheme_path=/home/${user}/.config/qt5ct/colors/numix.conf
    custom_palette=true
    icon_theme=${theme.colors.name.icon}
    standard_dialogs=default
    style=${name.qt_style}

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

  rgbpallete = let
    split = float: builtins.head (lib.strings.splitString "." float);
    split_all = data: lib.attrsets.mapAttrs (_: value: split (toString value)) data;
  in
    with pkgs.lib.nix-rice; {
      black = split_all (color.hexToRgba theme.colors.black);
      bg = split_all (color.hexToRgba theme.colors.background);
      altbg = split_all (color.hexToRgba theme.colors.background2);
      fg = split_all (color.hexToRgba theme.colors.foreground);
      fginactive = split_all (color.hexToRgba theme.colors.brightgray);
      green = split_all (color.hexToRgba theme.colors.green);
      brightgreen = split_all (color.hexToRgba theme.colors.brightgreen);
      brightred = split_all (color.hexToRgba theme.colors.brightred);
      orange = split_all (color.hexToRgba theme.colors.brightred);
    };

  kdeglobal = let
    rgb_str = rgb_map: "${rgb_map.r},${rgb_map.g},${rgb_map.b}";
  in
    with rgbpallete; ''
      [Colors:View]
      BackgroundAlternate=${rgb_str altbg}
      BackgroundNormal=${rgb_str bg}
      DecorationFocus=${rgb_str bg}
      DecorationHover=${rgb_str bg}
      ForegroundActive=${rgb_str bg}
      ForegroundInactive=${rgb_str fginactive}
      ForegroundLink=${rgb_str brightgreen}
      ForegroundNegative=${rgb_str brightred}
      ForegroundNeutral=${rgb_str orange}
      ForegroundNormal=${rgb_str fg}
      ForegroundPositive=${rgb_str green}
      ForegroundVisited=${rgb_str fginactive}

      [KFileDialog Settings]
      Allow Expansion=false
      Automatically select filename extension=true
      Breadcrumb Navigation=true
      Decoration position=2
      LocationCombo Completionmode=5
      PathCombo Completionmode=5
      Show Bookmarks=false
      Show Full Path=false
      Show Inline Previews=true
      Show Preview=false
      Show Speedbar=true
      Show hidden files=true
      Sort by=Name
      Sort directories first=true
      Sort hidden files last=false
      Sort reversed=false
      Speedbar Width=101
      View Style=DetailTree

      [KShortcutsDialog Settings]
      Dialog Size=600,480

      [General]
      TerminalApplication=wezterm
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

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          libsForQt5.qt5ct
          # libsForQt5.qtstyleplugin-kvantum
          oomox
          qgnomeplatform
          adwaita-qt
          gtk3
        ];
        pointerCursor = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
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
          name = "phinger-cursors";
          size = 24;
        };
      };
      qt = with theme.colors; {
        enable = true;
        # gtk, gnome, lxqt, qt5ct, kde
        # platformTheme = "gnome";
        # style = {
        #   name = "${name.qt_style}";
        # };
      };
      home.file.".config/Kvantum/kvantum.kvconfig".text = kvtheme;
      home.file.".config/qt5ct/qt5ct.conf".text = qt5ct;
      home.file.".config/kdeglobals".text = kdeglobal;
      home.file.".config/qt5ct/colors/numix.conf" = {
        source = "${oomox}/.config/qt5ct/colors/numix.conf";
      };
    };
  }
