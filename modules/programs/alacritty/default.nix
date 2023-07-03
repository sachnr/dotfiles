{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.programs.alacritty;
in
  with lib; {
    options.modules.programs.alacritty = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable alacritty";
      };
    };

    config = mkIf cfg.enable {
      programs.alacritty = {
        enable = true;
        settings = with theme; {
          window = {
            padding = {
              x = 10;
              y = 10;
            };
            decorations = "none";
            dynamic_padding = true;
            decorations_theme_variant = "Dark";
            opacity = 0.9;
          };
          font = {
            normal = {
              family = "Iosevka Comfy";
            };
            bold = {
              family = "Iosevka Comfy";
              style = "Bold";
            };
            italic = {
              family = "Iosevka Comfy";
              style = "Italic";
            };
            bold_italic = {
              family = "Iosevka Comfy";
              style = "Bold Italic";
            };
            size = 12;
          };
          window.dimensions = {
            lines = 3;
            columns = 200;
          };
          bell = {
            animation = "EaseOutExpo";
            duration = 2;
            color = foreground;
          };
          cursor = {
            style = {
              shape = "Beam";
              blinking = "Always";
            };
            vi_mode_style = "Block";
            blink_interval = 500;
            blink_timeout = 15;
            unfocused_hollow = true;
            thickness = 1;
          };

          colors = {
            primary = {
              background = background;
              foreground = foreground;
              dim_foreground = "#828482";
              bright_foreground = "#eaeaea";
            };
            cursor = {
              text = background;
              cursor = foreground;
            };
            vi_mode_cursor = {
              text = background;
              cursor = foreground;
            };
            search = {
              matches = {
                foreground = foreground;
                background = background3;
              };
              focused_match = {
                foreground = background;
                background = blue;
              };
            };
            line_indicator = {
              foreground = foreground;
              background = background;
            };
            footer_bar = {
              foreground = foreground;
              background = background2;
            };
            selection = {
              text = background;
              background = selection;
            };
            normal = {
              black = black;
              red = red;
              green = green;
              yellow = yellow;
              blue = blue;
              magenta = purple;
              cyan = aqua;
              white = gray;
            };
            bright = {
              black = brightblack;
              red = brightred;
              green = brightgreen;
              yellow = brightyellow;
              blue = brightblue;
              magenta = brightpurple;
              cyan = brightaqua;
              white = brightgray;
            };
          };
        };
      };
    };
  }
