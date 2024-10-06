{ config, lib, theme, ... }:
let cfg = config.modules.programs.alacritty;
in with lib; {
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
      settings = with theme.colors; {
        env = { TERM = "xterm-256color"; };
        keyboard.bindings = [
          {
            key = "Plus";
            mods = "Control|Shift";
            action = "IncreaseFontSize";
          }
          {
            key = "Minus";
            mods = "Control|Shift";
            action = "DecreaseFontSize";
          }
          {
            key = "Key0";
            mods = "Control|Shift";
            action = "ResetFontSize";
          }
        ];
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          decorations = "full";
          dynamic_padding = true;
          decorations_theme_variant = "Dark";
          opacity = 0.9;
          dimensions = {
            columns = 120;
            lines = 30;
          };
        };
        font = {
          normal = { family = "Iosevka"; };
          bold = {
            family = "Iosevka";
            style = "Bold";
          };
          italic = {
            family = "Iosevka";
            style = "Italic";
          };
          bold_italic = {
            family = "Iosevka";
            style = "Bold Italic";
          };
          size = 14;
        };
        # bell = {
        #   animation = "EaseOutExpo";
        #   duration = 2;
        #   color = primary.background;
        # };
        cursor = { style = "Block"; };

        colors = {
          primary = {
            background = primary.background;
            foreground = primary.foreground;
            dim_foreground = normal.gray;
            bright_foreground = bright.gray;
          };
          cursor = {
            text = primary.background;
            cursor = primary.foreground;
          };
          vi_mode_cursor = {
            text = primary.background;
            cursor = primary.foreground;
          };
          search = {
            matches = {
              foreground = primary.foreground;
              background = primary.background3;
            };
            focused_match = {
              foreground = primary.background;
              background = primary.accent;
            };
          };
          line_indicator = {
            foreground = primary.foreground;
            background = primary.background;
          };
          footer_bar = {
            foreground = primary.foreground;
            background = primary.background2;
          };
          selection = {
            text = primary.background;
            background = primary.selection;
          };
          normal = {
            black = normal.black;
            red = normal.red;
            green = normal.green;
            yellow = normal.yellow;
            blue = normal.blue;
            magenta = normal.purple;
            cyan = normal.cyan;
            white = normal.gray;
          };
          bright = {
            black = bright.black;
            red = bright.red;
            green = bright.green;
            yellow = bright.yellow;
            blue = bright.blue;
            magenta = bright.purple;
            cyan = bright.cyan;
            white = bright.gray;
          };
        };
      };
    };
  };
}
