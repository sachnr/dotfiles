{ pkgs, config, lib, theme, user, ... }:
let
  cfg = config.modules.programs.gtk-qt;
  oomox = pkgs.callPackage ../../../pkgs/themix-gui.nix { inherit theme; };
  qt5ct = import ./qt5ct.nix { inherit theme user pkgs oomox; };
  qt6ct = import ./qt6ct.nix { inherit theme user pkgs oomox; };
  # kdeglobal = import ./kdeglobal.nix { inherit pkgs lib theme; };
in with lib; {
  options.modules.programs.gtk-qt = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Gtk + qt config";
    };
  };

  config = mkIf cfg.enable {
    home = {
      packages = with pkgs; [
        libsForQt5.qt5ct
        qt6Packages.qt6ct
        oomox
        adwaita-qt
        gtk3
      ];
      pointerCursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-light";
        size = 24;
        gtk.enable = true;
        x11.enable = true;
      };
      sessionVariables = { GTK_THEME = "${theme.settings.gtk}"; };
    };

    gtk = with theme; {
      enable = true;
      gtk3 = {
        extraConfig = {
          gtk-xft-antialias = 1;
          gtk-xft-hinting = 1;
          gtk-xft-hintstyle = "hintslight";
          gtk-xft-rgba = "rgb";
        };
        extraCss = with theme.colors; ''
          wnck-pager {
              color: ${bright.black};
              background-color: ${primary.background};
          }

          wnck-pager:selected {
              color: ${primary.background};
              background-color: ${primary.accent};
          }

          .xfce4-panel .background {
            background-color: ${normal.black};
          }
        '';
      };
      font = {
        name = theme.settings.font;
        size = 10;
      };
      theme.name = settings.gtk;
      iconTheme = { name = settings.icon; };
      cursorTheme = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors";
        size = 24;
      };
    };

    home.file.".config/qt5ct/qt5ct.conf".text = qt5ct;
    home.file.".config/qt6ct/qt6ct.conf".text = qt6ct;
    # home.file.".config/kdeglobals".text = qt6ct;
  };
}
