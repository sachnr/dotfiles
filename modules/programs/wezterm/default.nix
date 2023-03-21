{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.programs.wezterm;
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
        package = pkgs.wezterm-git;
        colorSchemes = {
          nixtheme = with theme.colors; {
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
                intensity = "Normal";
                underline = "None";
                italic = false;
                strikethrough = false;
              };
              inactive_tab_hover = {
                bg_color = background;
                fg_color = foreground;
                intensity = "Normal";
                underline = "None";
                italic = false;
                strikethrough = false;
              };
              new_tab = {
                bg_color = background;
                fg_color = brightblue;
              };
              new_tab_hover = {
                bg_color = background;
                fg_color = foreground;
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
        extraConfig = ''
          local wezterm = require 'wezterm'
          local act = wezterm.action
          local keybinds = {
            { key="UpArrow", mods="SHIFT|CTRL", action= act.ScrollByPage(0.5) },
            { key="DownArrow", mods="SHIFT|CTRL", action= act.ScrollByPage(-0.5) },
            { key="c", mods="SHIFT|CTRL", action= act.CopyTo 'ClipboardAndPrimarySelection'},
            { key="v", mods="SHIFT|CTRL", action= act.PasteFrom 'PrimarySelection' },
            { key="-", mods="CTRL", action= act.DecreaseFontSize },
            { key="=", mods="CTRL", action= act.IncreaseFontSize },
            { key="Backspace", mods="SHIFT|CTRL", action= act.ResetFontSize },
            { key = 'LeftArrow', mods = 'CTRL|ALT', action = act.MoveTabRelative(-1) },
            { key = 'RightArrow', mods = 'CTRL|ALT', action = act.MoveTabRelative(1) },
            { key="LeftArrow", mods="SHIFT|CTRL", action= act.ActivateTabRelative(-1) },
            { key="RightArrow", mods="SHIFT|CTRL", action= act.ActivateTabRelative(1) },
            { key="w", mods="SHIFT|CTRL", action= act.CloseCurrentTab { confirm = true }, },
            { key="t", mods="SHIFT|CTRL", action= act.SpawnTab 'CurrentPaneDomain' },
          }
          for i = 1, 9 do
            table.insert(keybinds, {
              key = tostring(i),
              mods = 'CTRL|ALT',
              action = act.ActivateTab(i - 1),
            })
          end
          return {
            font = wezterm.font("JetBrains Mono"),
            use_fancy_tab_bar  = false,
            font_size = 10.5,
            max_fps = 60,
            color_scheme = 'nixtheme',
            check_for_updates = false,
            hide_tab_bar_if_only_one_tab = false,
            disable_default_key_bindings = true,
            enable_scroll_bar = true,
            keys = keybinds,
          }
        '';
      };
    };
  }
