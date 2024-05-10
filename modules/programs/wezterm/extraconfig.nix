{ theme }:
with theme.colors; ''
  local act = wezterm.action
  local wezterm = require 'wezterm'

  wezterm.on('update-right-status', function(window, pane)
          local time = wezterm.strftime '%H:%M '
          local date = wezterm.strftime '%a %b %-d'
          window:set_right_status(wezterm.format {
              { Foreground = { Color = '${primary.accent}' } },
              { Text = '  ' .. date },
              { Text = '  ' .. time },
              })
          end)

  local keybinds = {
    { key="UpArrow", mods="SHIFT|CTRL", action= act.ScrollByPage(0.5) },
    { key="DownArrow", mods="SHIFT|CTRL", action= act.ScrollByPage(-0.5) },
    { key="c", mods="SHIFT|CTRL", action= act.CopyTo 'ClipboardAndPrimarySelection'},
    { key="v", mods="SHIFT|CTRL", action= act.PasteFrom 'Clipboard' },
    { key="_", mods="SHIFT|CTRL", action= act.DecreaseFontSize },
    { key="+", mods="SHIFT|CTRL", action= act.IncreaseFontSize },
    { key="Backspace", mods="SHIFT|CTRL", action= act.ResetFontSize },
    { key = 'LeftArrow', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(-1) },
    { key = 'RightArrow', mods = 'SHIFT|CTRL', action = act.MoveTabRelative(1) },
    { key="LeftArrow", mods="SHIFT|CTRL", action= act.ActivateTabRelative(-1) },
    { key="RightArrow", mods="SHIFT|CTRL", action= act.ActivateTabRelative(1) },
    { key="d", mods="SHIFT|CTRL", action= act.CloseCurrentTab { confirm = true }, },
    { key="t", mods="SHIFT|CTRL", action= act.SpawnTab 'CurrentPaneDomain' },
    { key="w", mods="SHIFT|CTRL", action= act.SpawnWindow },
    { key = 'L', mods = 'CTRL', action = wezterm.action.ShowDebugOverlay },
    { key = 'i', mods = 'CTRL|SHIFT', action = act.SwitchToWorkspace },
  }

  for i = 1, 9 do
    table.insert(keybinds, {
      key = tostring(i),
      mods = 'SHIFT|CTRL',
      action = act.ActivateTab(i - 1),
    })
  end

   local colors = {
      foreground = "${primary.foreground}",
      background = "${primary.background}",

      cursor_bg = "${primary.foreground}",
      cursor_fg = "${primary.background}",
      cursor_border = "${primary.accent}",

      selection_fg = "${normal.gray}",
      selection_bg = "${primary.selection}",

      scrollbar_thumb = "${primary.background}",
      split = "${primary.accent}",

      ansi = { "${normal.black}", "${normal.red}", "${normal.green}", "${normal.yellow}", "${normal.blue}", "${normal.purple}", "${normal.cyan}", "${normal.gray}" },
      brights = { "${bright.black}", "${bright.red}", "${bright.green}", "${bright.yellow}", "${bright.blue}", "${bright.purple}", "${bright.cyan}", "${bright.gray}" },
      indexed = { [16] = "${normal.gray}", [17] = "#ff5d62" },
       compose_cursor = "${normal.blue}",
    }

  return {
    font = wezterm.font_with_fallback { "Iosevka" },
    font_size = 12,
    bold_brightens_ansi_colors = true,
    -- use_fancy_tab_bar = false,
    front_end = "WebGpu",
    -- freetype_load_target = "Normal",
    -- freetype_load_flags = 'NO_AUTOHINT',
    -- underline_position = "125%",
    cursor_blink_rate = 0,
    -- line_height = 1.0,
    adjust_window_size_when_changing_font_size = false,
    -- color_scheme = "Kanagawa (Gogh)",
    -- color_scheme = "Gruvbox",
    default_cursor_style = "SteadyBar",
    check_for_updates = false,
    -- hide_tab_bar_if_only_one_tab = true,
    disable_default_key_bindings = true,
    enable_scroll_bar = true,
    enable_tab_bar = false,
    -- freetype_load_target = 'Light',
    -- freetype_render_target = 'HorizontalLcd',
    keys = keybinds,
    colors = colors,
  }
''
