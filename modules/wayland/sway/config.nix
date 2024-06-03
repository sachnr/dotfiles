{ theme, pkgs, ... }:
with theme.colors; ''
    set $mod Mod4
    set $alt Mod1

    bindsym $mod+q kill
    bindsym $alt+space exec rofi -show drun
    bindsym $mod+Return exec alacritty
    bindsym $mod+Shift+r reload
    bindsym $mod+f fullscreen toggle
    bindsym Print exec grim -t png -g "$(slurp)" ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png

    output DP-2 position 0,0
    output eDP-1 position 1920,0

    # Workspace
    bindsym $mod+Tab workspace back_and_forth
    bindsym $mod+Shift+n workspace next
    bindsym $mod+Shift+p workspace prev
    bindsym $mod+1 workspace number 1
    bindsym $mod+2 workspace number 2
    bindsym $mod+3 workspace number 3
    bindsym $mod+4 workspace number 4
    bindsym $mod+5 workspace number 5
    bindsym $mod+6 workspace number 6
    bindsym $mod+7 workspace number 7
    bindsym $mod+8 workspace number 8
    bindsym $mod+9 workspace number 9
    bindsym $mod+Shift+1 move container to workspace number 1
    bindsym $mod+Shift+2 move container to workspace number 2
    bindsym $mod+Shift+3 move container to workspace number 3
    bindsym $mod+Shift+4 move container to workspace number 4
    bindsym $mod+Shift+5 move container to workspace number 5
    bindsym $mod+Shift+6 move container to workspace number 6
    bindsym $mod+Shift+7 move container to workspace number 7
    bindsym $mod+Shift+8 move container to workspace number 8
    bindsym $mod+Shift+9 move container to workspace number 9

    # scratchpad
    bindsym $mod+minus scratchpad show
    bindsym $mod+Shift+minus move scratchpad

    # focus
    bindsym $mod+a focus parent

    # focus 
    bindsym $mod+h focus left
    bindsym $mod+j focus down
    bindsym $mod+k focus up
    bindsym $mod+l focus right

    # Move
    bindsym $mod+Shift+h move left
    bindsym $mod+Shift+j move down
    bindsym $mod+Shift+k move up
    bindsym $mod+Shift+l move right

    # Layout
    bindsym $mod+s layout stacking
    bindsym $mod+space focus mode_toggle
    bindsym $mod+t floating toggle
    bindsym $mod+v splitv
    bindsym $mod+b splith
    bindsym $mod+w layout tabbed
    bindsym $mod+e layout toggle split

    # Resize
    bindsym $mod+r mode resize
    mode "resize" {
    bindsym Down resize grow height 10 px
    bindsym Escape mode default
    bindsym Left resize shrink width 10 px
    bindsym Return mode default
    bindsym Right resize grow width 10 px
    bindsym Up resize shrink height 10 px
    bindsym h resize shrink width 10 px
    bindsym j resize grow height 10 px
    bindsym k resize shrink height 10 px
    bindsym l resize grow width 10 px
  }

  bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'

  font pango:monospace 8.000000
  floating_modifier $mod
  default_border pixel 1
  gaps inner 6
  smart_gaps off
  tiling_drag enable
  default_floating_border pixel 1
  hide_edge_borders none
  focus_wrapping no
  focus_follows_mouse yes
  focus_on_window_activation smart
  mouse_warping output
  workspace_layout default
  workspace_auto_back_and_forth no

  # class        border backgr. text indicator child_border
  client.focused ${primary.accent} ${primary.background} ${primary.foreground} ${primary.accent} ${primary.accent}
  client.focused_inactive ${primary.background} ${primary.background} ${primary.foreground} ${primary.accent} ${primary.accent}
  client.unfocused ${primary.background} ${primary.background} ${normal.gray} ${primary.selection} ${normal.black}
  client.urgent ${normal.red} ${primary.background} ${primary.foreground} ${bright.black} ${normal.black}
  # ignored i3 compatiblity
  client.placeholder #000000 #0c0c0c #ffffff #000000 #0c0c0c
  client.background #ffffff

  for_window [app_id="gnome-calculator"] floating enable
  for_window [class="(?i)Lxappearance$"] floating enable
  for_window [app_id="(?i)mpv"] floating enable
  for_window [app_id="pavucontrol"] floating enable
  for_window [app_id="nm-connection-editor$"] floating enable
  for_window [app_id="gnome-(calendar|calculator|power-statistics|control-center)"] floating enable
  for_window [window_role="GtkFileChooserDialog"] floating enable
  for_window [window_role="GtkFileChooserDialog"] resize set 800 600
  for_window [window_role="GtkFiileChooserDialog"] move position center
  for_window [app_id="org.kde.ark"] floating enable
  for_window [app_id="veracrypt"] floating enable
  for_window [title="Library"] floating enable
  for_window [title="Steam Guard"] floating enable
  for_window [class="(?i)steam_app$"] inhibit_idle focus
  for_window [class="(?i)steam_app$"] max_render_time 3

  for_window [window_role="pop-up"] floating enable
  for_window [window_role="bubble"] floating enable
  for_window [window_role="task_dialog"] floating enable
  for_window [window_role="Preferences"] floating enable
  for_window [window_type="dialog"] floating enable
  for_window [window_type="menu"] floating enable
  for_window [instance="update_installer"] floating enable
  for_window [instance="feh"] floating enable

  # ScratchPad - Dropdown Windows
  # General dropdown window traits. The order can matter.
  for_window [title="Dropdown *"] floating enable
  for_window [title="Dropdown *"] move scratchpad
  for_window [title="Dropdown *"] sticky enable
  for_window [title="Dropdown *"] scratchpad show
  for_window [title="Dropdown *"] resize set width 625
  for_window [title="Dropdown *"] resize set height 400
  for_window [title="Dropdown *"] border pixel 3
  for_window [title="Dropdown *"] move position center
  # General dropdown window traits. The order can matter.
  for_window [title="Dropdown Launcher*"] floating enable
  for_window [title="Dropdown Launcher*"] move scratchpad
  for_window [title="Dropdown Launcher*"] sticky enable
  for_window [title="Dropdown Launcher*"] scratchpad show
  for_window [title="Dropdown Launcher*"] resize set width 225
  for_window [title="Dropdown Launcher*"] resize set height 100
  for_window [title="Dropdown Launcher*"] border pixel 0
  for_window [title="Dropdown Launcher*"] move position center

  input type:pointer {
    accel_profile flat
  }

  bar {
    position top
    status_command i3status-rs ~/.config/i3status/config.toml
    font pango:Roboto 8 Bold, Symbols Nerd Font Mono 9

    colors {
        statusline ${primary.foreground}
        separator ${primary.accent}
        background ${primary.background} 
        active_workspace ${primary.background} ${primary.background} ${primary.accent}
        inactive_workspace ${primary.background} ${primary.background} ${primary.foreground}
        focused_workspace ${primary.accent} ${primary.accent} ${primary.background}
        urgent_workspace ${normal.red} ${normal.red} ${primary.foreground}
    }
  }

  exec wpaperd
  # exec_always wpaperd
''
