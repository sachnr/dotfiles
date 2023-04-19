{theme}:
with theme.colors; ''
  local act = wezterm.action
  local wezterm = require 'wezterm'

  wezterm.on('update-right-status', function(window, pane)
          local time = wezterm.strftime '%H:%M '
          local date = wezterm.strftime '%a %b %-d'
          local workspace = window:active_workspace()
          window:set_right_status(wezterm.format {
              { Foreground = { Color = '${brightblue}' } },
              { Text = workspace },
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
  }

  for i = 1, 9 do
    table.insert(keybinds, {
      key = tostring(i),
      mods = 'SHIFT|CTRL',
      action = act.ActivateTab(i - 1),
    })
  end

  return {
    font = wezterm.font_with_fallback({
        {
            family = "JetBrains Mono",
            -- weight = 'Regular',
            -- harfbuzz_features = { "cv01" , "cv04" , "ss01" }
        },
    }),
    foreground_text_hsb = {
      hue = 1.0,
      saturation = 1.0,
      brightness = 1.0,
    },
    font_size = 10.6,
    underline_position = '125%',
    dpi = 94,
    use_fancy_tab_bar  = false,
    freetype_load_target = "Normal",
    freetype_load_flags = "DEFAULT",
    adjust_window_size_when_changing_font_size = false,
    max_fps = 60,
    color_scheme = "nixtheme",
    colors = {
        compose_cursor = '${orange}',
    },
    check_for_updates = false,
    hide_tab_bar_if_only_one_tab = false,
    disable_default_key_bindings = true,
    enable_scroll_bar = true,
    keys = keybinds,
  }
''
