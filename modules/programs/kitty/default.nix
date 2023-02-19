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
          font_family = "JetBrains Mono Medium Nerd Font Complete";
          italic_font = "JetBrains Mono Medium Italic Nerd Font Complete";
          bold_font = "JetBrains Mono Bold Nerd Font Complete";
          bold_italic_font = "JetBrains Mono Bold Italic Nerd Font Complete";
          font_size = "10.6";
          modify_font = "underline_position 125%";

          adjust_line_height = "0";
          adjust_column_width = "0";
          box_drawing_scale = "0.001, 1, 1.5, 2";

          # Cursor
          cursor_blink_interval = "-1";
          cursor_stop_blinking_after = "15.0";

          # Scrollback
          scrollback_lines = 10000;
          # scrollback_pager = "/bin/less";
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
          background_opacity = "0.95";
          placement_strategy = "center";
          hide_window_decorations = false;

          # Tabs
          tab_bar_edge = "top";
          tab_bar_style = "powerline";
          tab_powerline_style = "round";
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
          color0 = xcolor0;
          color1 = xcolor1;
          color2 = xcolor2;
          color3 = xcolor3;
          color4 = xcolor4;
          color5 = xcolor5;
          color6 = xcolor6;
          color7 = xcolor7;
          color8 = xcolor8;
          color9 = xcolor9;
          color10 = xcolor10;
          color11 = xcolor11;
          color12 = xcolor12;
          color13 = xcolor13;
          color14 = xcolor14;
          color15 = xcolor15;

          background = base00;
          foreground = xcolor15;
          cursor = xcolor15;
          selection_foreground = xcolor15;
          selection_background = base01;
          active_border_color = xcolor4;
          inactive_border_color = base00;
          url_color = xcolor14;
          active_tab_foreground = xcolor0;
          active_tab_background = xcolor4;
          inactive_tab_foreground = xcolor8;
          inactive_tab_background = base02;
          tab_bar_background = base01;
        };
        keybindings = {
          "ctrl+shift+up" = "scroll_page_up";
          "ctrl+shift+down" = "scroll_page_down";
          "ctrl+shift+left" = "previous_tab";
          "ctrl+shift+right" = "next_tab";
          "ctrl+shift+v" = "paste_from_clipboard";
          "ctrl+shift+c" = "copy_to_clipboard";
          "ctrl+shift+equal" = "increase_font_size";
          "ctrl+shift+minus" = "decrease_font_size";
          "ctrl+shift+backspace" = "restore_font_size";
          "ctrl+b>s" = "set_background_opacity +0.05";
          "ctrl+b>a" = "set_background_opacity -0.05";
          "ctrl+b>t" = "new_tab_with_cwd";
          "ctrl+b>q" = "close_tab";
          "ctrl+b>," = "set_tab_title";
          "ctrl+b>1" = "goto_tab 1";
          "ctrl+b>2" = "goto_tab 2";
          "ctrl+b>3" = "goto_tab 3";
          "ctrl+b>4" = "goto_tab 4";
          "ctrl+b>5" = "goto_tab 5";
          "ctrl+b>6" = "goto_tab 6";
          "ctrl+b>7" = "goto_tab 7";
          "ctrl+b>8" = "goto_tab 8";
          "ctrl+b>9" = "goto_tab 9";
        };
      };
    };
  }
