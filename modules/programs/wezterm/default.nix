{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.programs.wezterm;
  extracfg = import ./extraconfig.nix {inherit theme;};
in
  with lib; {
    options.modules.programs.wezterm = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable wezterm";
      };
    };

    config = mkIf cfg.enable {
      programs.wezterm = {
        enable = true;
        colorSchemes = {
          nixtheme = with theme; {
            ansi = [
              black
              red
              green
              yellow
              blue
              purple
              aqua
              gray
            ];
            brights = [
              brightblack
              brightred
              brightgreen
              brightyellow
              brightblue
              brightpurple
              brightaqua
              brightgray
            ];
            tab_bar = {
              background = background;
              active_tab = {
                bg_color = background;
                fg_color = brightblue;
                intensity = "Bold";
                underline = "None";
                italic = false;
                strikethrough = false;
              };
              inactive_tab = {
                bg_color = background;
                fg_color = gray;
              };
              inactive_tab_hover = {
                bg_color = background;
                fg_color = foreground;
              };
              new_tab = {
                bg_color = background;
                fg_color = blue;
                intensity = "Normal";
              };
              new_tab_hover = {
                bg_color = background;
                fg_color = brightblue;
                intensity = "Bold";
              };
            };
            background = background;
            cursor_bg = foreground;
            cursor_border = foreground;
            cursor_fg = black;
            foreground = foreground;
            selection_bg = selection;
            selection_fg = foreground;
            scrollbar_thumb = black;
          };
        };
        extraConfig = extracfg;
      };
    };
  }
