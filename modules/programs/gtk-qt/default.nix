{
  pkgs,
  config,
  lib,
  theme,
  user,
  ...
}: let
  cfg = config.modules.programs.gtk-qt;
  oomox = pkgs.callPackage ../../../pkgs/themix-gui.nix {inherit theme;};
  qt5ct = import ./qt5ct.nix {inherit theme user pkgs oomox;};
  qt-stylesheet = import ./qt-stylesheet.nix;
  # global config for kde ecosystem apps like dolphin etc, not currently using this
  # kdeglobal = import ./kdeglobal.nix {inherit pkgs lib theme;};
in
  with lib; {
    options.modules.programs.gtk-qt = {
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
          qt6Packages.qt6ct
          # libsForQt5.qtstyleplugin-kvantum
          oomox
          adwaita-qt # adds styles in qt5ct
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
          GTK_THEME = "${theme.settings.gtk}";
        };
      };

      gtk = with theme; {
        enable = true;
        gtk3.extraConfig = {
          gtk-xft-antialias = 1;
          gtk-xft-hinting = 1;
          gtk-xft-hintstyle = "hintslight";
          gtk-xft-rgba = "rgb";
          # gtk-application-prefer-dark-theme = 1;
        };
        font = {
          name = "Roboto";
          size = 10;
        };
        theme.name = settings.gtk;
        iconTheme = {
          name = settings.icon;
        };
        cursorTheme = {
          package = pkgs.phinger-cursors;
          name = "phinger-cursors";
          size = 24;
        };
      };

      home.file.".config/qt5ct/qt5ct.conf".text = qt5ct;

      # home.file.".config/kdeglobals".text = kdeglobal;

      ## i dont use kvantum anyomore
      # home.file.".config/Kvantum/kvantum.kvconfig".text = let
      #   kvtheme = ''
      #     [General]
      #     theme=${theme.settings.kvantum}
      #   '';
      # in
      #   kvtheme;
    };
  }
