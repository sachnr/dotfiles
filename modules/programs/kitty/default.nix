{ pkgs, config, lib, theme, ... }:
let cfg = config.modules.programs.kitty;
in with lib; {
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
        font_family = "Iosevka";
        symbol_map =
          "U+23FB-U+23FE,U+2665,U+26A1,U+2B58,U+E000-U+E00A,U+E0A0-U+E0A3,U+E0B0-U+E0C8,U+E0CA,U+E0CC-U+E0D2,U+E0D4,U+E200-U+E2A9,U+E300-U+E3E3,U+E5FA-U+E634,U+E700-U+E7C5,U+EA60-U+EBEB,U+F000-U+F2E0,U+F300-U+F32F,U+F400-U+F4A9,U+F500-U+F8FF Symbols Nerd Font Mono";
        font_size = "16";
        # font_features = "JetBrains Mono +cv06 +cv07";
        modify_font = "underline_position 125%";

        disable_ligatures = "never";
        box_drawing_scale = "0.001, 1, 1.5, 2";

        # Cursor
        cursor_blink_interval = "0";
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
        window_padding_width = "2";
        inactive_text_alpha = "1.0";
        dynamic_background_opacity = true;
        background_opacity = "0.96";
        placement_strategy = "center";
        hide_window_decorations = true;

        # Tabs
        tab_bar_edge = "top";
        tab_bar_min_tabs = 2;
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
        color0 = normal.black;
        color1 = normal.red;
        color2 = normal.green;
        color3 = normal.yellow;
        color4 = normal.blue;
        color5 = normal.purple;
        color6 = normal.cyan;
        color7 = normal.gray;
        color8 = bright.black;
        color9 = bright.red;
        color10 = bright.green;
        color11 = bright.yellow;
        color12 = bright.blue;
        color13 = bright.purple;
        color14 = bright.cyan;
        color15 = bright.gray;

        background = primary.background;
        foreground = primary.foreground;
        cursor = primary.foreground;
        cursor_text_color = primary.background;

        selection_foreground = primary.background;
        selection_background = primary.selection;
        active_border_color = primary.accent;
        inactive_border_color = primary.background;

        url_color = bright.green;

        active_tab_foreground = primary.accent;
        active_tab_background = primary.background;
        inactive_tab_foreground = normal.gray;
        inactive_tab_background = primary.background;
        tab_bar_background = normal.black;
      };
      keybindings = {
        "ctrl+shift+up" = "scroll_page_up";
        "ctrl+shift+down" = "scroll_page_down";
        "ctrl+shift+left" = "previous_tab";
        "ctrl+shift+right" = "next_tab";
        "ctrl+shift+v" = "paste_from_clipboard";
        "ctrl+shift+c" = "copy_to_clipboard";
        "ctrl+shift+equal" = "change_font_size current +0.5";
        "ctrl+shift+minus" = "change_font_size current -0.5";
        "ctrl+shift+backspace" = "restore_font_size";
        "ctrl+alt+s" = "set_background_opacity +0.02";
        "ctrl+alt+a" = "set_background_opacity -0.02";
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
      };
    };
    home.file.".config/kitty/tab_bar.py".source = ./tab_bar.py;
  };
}
