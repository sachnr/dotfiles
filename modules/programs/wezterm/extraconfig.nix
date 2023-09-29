{theme}:
with theme; ''
  local act = wezterm.action
  local wezterm = require 'wezterm'

  wezterm.on('update-right-status', function(window, pane)
          local time = wezterm.strftime '%H:%M '
          local date = wezterm.strftime '%a %b %-d'
          window:set_right_status(wezterm.format {
              { Foreground = { Color = '${brightblue}' } },
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
  }

  for i = 1, 9 do
    table.insert(keybinds, {
      key = tostring(i),
      mods = 'SHIFT|CTRL',
      action = act.ActivateTab(i - 1),
    })
  end

   local colors = {
      foreground = "${foreground}",
      background = "${background}",

      cursor_bg = "${gray}",
      cursor_fg = "${gray}",
      cursor_border = "${gray}",

      selection_fg = "${gray}",
      selection_bg = "${selection}",

      scrollbar_thumb = "${background}",
      split = "${background}",

      ansi = { "${black}", "${red}", "${green}", "${yellow}", "${blue}", "${purple}", "${aqua}", "${gray}" },
      brights = { "${brightblack}", "${brightred}", "${brightgreen}", "${brightyellow}", "${brightblue}", "${brightpurple}", "${brightaqua}", "${brightgray}" },
      indexed = { [16] = "${gray}", [17] = "#ff5d62" },
       compose_cursor = "${orange}",
    }

  return {
    font = wezterm.font("JetBrains Mono", { weight = "Regular" }),
    foreground_text_hsb = {
        hue = 1.0,
        saturation = 1.0,
        brightness = 0.9,
    },
    font_size = 11.5,
    bold_brightens_ansi_colors = false,
    use_fancy_tab_bar = false,
    underline_position = "125%",
    cursor_blink_rate = 0,
    line_height = 1.0,
    front_end = "WebGpu",
    freetype_load_target = "Normal",
    freetype_render_target = "Light",
    freetype_load_flags = 'DEFAULT',
    adjust_window_size_when_changing_font_size = false,
    color_scheme = "nixtheme",
    -- color_scheme = "Kanagawa (Gogh)",
    -- color_scheme = "Gruvbox",
    default_cursor_style = "SteadyBar",
    force_reverse_video_cursor = true,
    check_for_updates = false,
    hide_tab_bar_if_only_one_tab = true,
    disable_default_key_bindings = true,
    enable_scroll_bar = true,
    keys = keybinds,
    colors = colors,
  }
''
