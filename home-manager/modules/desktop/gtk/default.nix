{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.modules.desktop.gtk;
  theme = import ../../theme {};
  kvtheme = ''
    [General]
    theme=${theme.colors.name.kvantum}
  '';
  qt5ct = ''
    [Appearance]
    custom_palette=false
    icon_theme=${theme.colors.name.icon}
    standard_dialogs=default
    style=kvantum-dark

    [Fonts]
    fixed=@Variant(\0\0\0@\0\0\0.\0J\0\x65\0t\0\x42\0r\0\x61\0i\0n\0s\0M\0o\0n\0o\0 \0N\0\x65\0r\0\x64\0 \0\x46\0o\0n\0t@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)
    general=@Variant(\0\0\0@\0\0\0\f\0R\0o\0\x62\0o\0t\0o@$\0\0\0\0\0\0\xff\xff\xff\xff\x5\x1\0\x32\x10)
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

    config = mkIf (cfg.enable) {
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
      home.file.".config/Kvantum/kvantum.kvconfig".text = kvtheme;
      home.file.".config/qt5ct/qt5ct.conf".text = qt5ct;
    };
  }
