''
  for_window [class="^.*"] border pixel 2
  for_window [class="gnome-calculator"] floating enable
  for_window [class="(?i)Lxappearance$"] floating enable
  for_window [class="(?i)mpv"] floating enable
  for_window [class="pavucontrol"] floating enable
  for_window [class="nm-connection-editor$"] floating enable
  for_window [class="gnome-(calendar|calculator|power-statistics|control-center)"] floating enable
  for_window [window_role="GtkFileChooserDialog"] floating enable
  for_window [window_role="GtkFileChooserDialog"] resize set 800 600
  for_window [window_role="GtkFiileChooserDialog"] move position center
  for_window [class="org.kde.ark"] floating enable
  for_window [class="veracrypt"] floating enable
  for_window [title="Library"] floating enable
  for_window [title="Steam Guard"] floating enable

  for_window [window_role="pop-up"] floating enable
  for_window [window_role="bubble"] floating enable
  for_window [window_role="task_dialog"] floating enable
  for_window [window_role="Preferences"] floating enable
  for_window [window_type="dialog"] floating enable
  for_window [window_type="menu"] floating enable
  for_window [instance="update_installer"] floating enable
  for_window [instance="feh"] floating enable


    assign [class="kitty"] 1
    for_window [class="kitty"]  workspace number 1
    assign [class="firefox"] 2
    assign [class="org.qutebrowser.qutebrowser"] 2
    for_window [class="firefox|org.qutebrowser.qutebrowser"]  workspace number 2
    assign [class="dolphin"] 4
    for_window [class="dolphin"]  workspace number 4
    assign [class="veracrypt"] 6
    for_window [class="veracrypt"]  workspace number 6
    assign [class="steam"] 7
    for_window [class="steam"]  workspace number 7
''
