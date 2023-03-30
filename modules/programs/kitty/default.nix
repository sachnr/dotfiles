{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.programs.kitty;
in
  with lib; {
    options.modules.programs.kitty = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable kitty";
      };
    };

    config = mkIf cfg.enable {
      programs.kitty = {
        enable = true;
        settings = with theme.colors; {
          clear_all_shortcuts = true;
          # Fonts
          font_family = "JetBrains Mono Regular";
          italic_font = "JetBrains Mono Regular Italic";
          bold_font = "JetBrains Mono Bold";
          bold_italic_font = "JetBrains Mono Bold Italic";
          symbol_map = "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E634,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font Mono";
          font_size = "10.6";
          modify_font = "underline_position 125%";

          disable_ligatures = "never";
          adjust_line_height = "0";
          adjust_column_width = "0";
          # box_drawing_scale = "0.001, 1, 1.5, 2";

          # Cursor
          cursor_blink_interval = "-1";
          cursor_stop_blinking_after = "15.0";

          # Scrollback
          scrollback_lines = 10000;
          scrollback_pager = "${pkgs.less}/bin/less";
          wheel_scroll_multiplier = "5.0";

          # URLs
          url_style = "double";
          open_url_modifiers = "ctrl+shift";
          open_url_with = "default";
          copy_on_select = true;

          # Mouse
          click_interval = "0.5";
          mouse_hide_wait = "0";
          focus_follows_mouse = false;

          # Bell
          visual_bell_duration = "0.0";
          enable_audio_bell = true;
          bell_on_tab = true;

          # Window
          remember_window_size = false;
          initial_window_width = "700";
          initial_window_height = "400";
          window_border_width = "0";
          window_margin_width = "0";
          window_padding_width = "10";
          inactive_text_alpha = "1.0";
          dynamic_background_opacity = true;
          background_opacity = "1";
          placement_strategy = "center";
          hide_window_decorations = false;

          # Tabs
          tab_bar_edge = "top";
          tab_bar_min_tabs = 1;
          tab_bar_style = "custom";
          tab_title_template = "{index}:{title} {bell_symbol}";
          tab_bar_margin_width = "2.0";
          tab_separator = " | ";
          active_tab_font_style = "bold";
          inactive_tab_font_style = "normal";

          # Shell
          shell = "zsh";
          close_on_child_death = false;
          allow_remote_control = true;
          # term = "xterm-kitty";

          # colors
          color0 = black;
          color1 = red;
          color2 = green;
          color3 = yellow;
          color4 = blue;
          color5 = purple;
          color6 = aqua;
          color7 = gray;
          color8 = brightblack;
          color9 = brightred;
          color10 = brightgreen;
          color11 = brightyellow;
          color12 = brightblue;
          color13 = brightpurple;
          color14 = brightaqua;
          color15 = brightgray;

          background = background;
          foreground = foreground;
          cursor = foreground;

          selection_foreground = background;
          selection_background = selection;
          active_border_color = brightblue;
          inactive_border_color = background;

          url_color = brightgreen;

          active_tab_foreground = brightblue;
          active_tab_background = background;
          inactive_tab_foreground = gray;
          inactive_tab_background = background;
          tab_bar_background = black;
        };
        keybindings = {
          "ctrl+shift+up" = "scroll_page_up";
          "ctrl+shift+down" = "scroll_page_down";
          "ctrl+shift+left" = "previous_tab";
          "ctrl+shift+right" = "next_tab";
          "ctrl+shift+v" = "paste_from_clipboard";
          "ctrl+shift+c" = "copy_to_clipboard";
          "ctrl+shift+equal" = "change_font_size current +1";
          "ctrl+shift+minus" = "change_font_size current -1";
          "ctrl+shift+backspace" = "restore_font_size";
          "ctrl+alt+s" = "set_background_opacity +0.05";
          "ctrl+alt+a" = "set_background_opacity -0.05";
          "ctrl+shift+t" = "new_tab_with_cwd";
          "ctrl+shift+d" = "close_tab";
          "ctrl+shift+," = "set_tab_title";
          "ctrl+shift+1" = "goto_tab 1";
          "ctrl+shift+2" = "goto_tab 2";
          "ctrl+shift+3" = "goto_tab 3";
          "ctrl+shift+4" = "goto_tab 4";
          "ctrl+shift+5" = "goto_tab 5";
          "ctrl+shift+6" = "goto_tab 6";
          "ctrl+shift+7" = "goto_tab 7";
          "ctrl+shift+8" = "goto_tab 8";
          "ctrl+shift+9" = "goto_tab 9";
          "ctrl+shift+f1" = "launch --stdin-source=@screen_scrollback --stdin-add-formatting less +G -R";
          "f2" = "new_window_with_cwd";
          "ctrl+f2" = "close_window";
        };
      };
      home.file.".config/kitty/tab_bar.py".source = ./tab_bar.py;
    };
  }
