{ theme }:
with theme.colors; ''
  icons_format = "{icon} "

  [theme]
  theme = "srcery"
  [theme.overrides]
  idle_bg = "${primary.background}"
  idle_fg = "${primary.foreground}"
  info_bg = "${primary.background}"
  info_fg = "${bright.cyan}"
  good_bg = "${normal.black}"
  good_fg = "${bright.green}"
  warning_bg = "${normal.black}"
  warning_fg = "${bright.yellow}"
  critical_bg = "${normal.black}"
  critical_fg = "${bright.red}"
  separator = "  |  "
  separator_bg = "auto"
  separator_fg = "${bright.black}"

  [icons]
  icons = "material-nf"

  [[block]]
  block = "net"
  format = " $icon {$signal_strength $ssid $frequency|Wired connection} via $device "

  [[block]]
  block = "temperature"
  format = " $icon $max max "
  format_alt = " $icon $min min, $max max, $average avg "
  interval = 10
  chip = "*-isa-*"

  [[block]]
  block = "battery"
  format = "$icon $percentage"
  device = "DisplayDevice"
  driver = "upower"

  [[block]]
  block = "backlight"
  device = "amdgpu_bl0"

  [[block]]
  block = "disk_space"
  info_type = "available"
  alert_unit = "GB"
  alert = 10.0
  warning = 15.0
  format = " $icon $available "
  format_alt = " $icon $available / $total "

  [[block]]
  block = "memory"
  format = " $icon $mem_used_percents.eng(w:1) "
  format_alt = " $icon_swap $swap_free.eng(w:3,u:B,p:Mi)/$swap_total.eng(w:3,u:B,p:Mi)($swap_used_percents.eng(w:2)) "
  interval = 30
  warning_mem = 70
  critical_mem = 90

  [[block]]
  block = "sound"
  [[block.click]]
  button = "left"
  cmd = "pavucontrol"

  [[block]]
  block = "sound"
  driver = "pulseaudio"
  device_kind = "source"
  format = " $icon { $volume|} {$active_port |}"
  [block.active_port_mappings]
  "analog-input-rear-mic" = "" # Mapping to an empty string makes `$active_port` absent
  "analog-input-front-mic" = "ERR!"

  [[block]]
  block = "time"
  interval = 5
  format = " $timestamp.datetime(f:'%I:%M  %d %b  %a') "
''
