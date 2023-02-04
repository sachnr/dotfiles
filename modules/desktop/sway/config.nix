{
  pkgs,
  theme,
  ...
}: let
in
  with theme.colors; ''
    exec ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY I3SOCK SWAYSOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user start sway-session.target
    exec ${pkgs.blueman}/bin/blueman-applet
    exec ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator

    font pango:monospace 8.000000
    floating_modifier Mod4
    default_border pixel 2
    gaps inner 10
    smart_gaps on
    tiling_drag enable
    default_floating_border pixel 2
    hide_edge_borders none
    focus_wrapping no
    focus_follows_mouse yes
    focus_on_window_activation smart
    mouse_warping output
    workspace_layout default
    workspace_auto_back_and_forth no

    # class        border backgr. text indicator child_border
    client.focused ${xcolor4} ${base00} ${xcolor15} ${xcolor12} ${xcolor4}
    client.focused_inactive ${xcolor4} ${xcolor0} ${xcolor15} ${xcolor12} ${xcolor4}
    client.unfocused ${base00} ${xcolor0} ${xcolor7} ${base01} ${base00}
    client.urgent ${xcolor1} ${xcolor0} ${xcolor7} ${base01} ${base00}
    # ignored i3 compatiblity
    client.placeholder #000000 #0c0c0c #ffffff #000000 #0c0c0c
    client.background #ffffff

    for_window [app_id="system-config-printer"] floating enable
    for_window [app_id="gnome-calculator"] floating enable
    for_window [class="(?i)Lxappearance$"] floating enable
    for_window [app_id="(?i)mpv"] floating enable
    for_window [app_id="pavucontrol"] floating enable
    for_window [app_id="pamac-manager"] floating enable
    for_window [app_id="nm-connection-editor$"] floating enable
    for_window [app_id="gnome-(calendar|calculator|power-statistics|control-center)"] floating enable
    for_window [window_role="GtkFileChooserDialog"] floating enable
    for_window [window_role="GtkFileChooserDialog"] resize set 800 600
    for_window [window_role="GtkFiileChooserDialog"] move position center
    for_window [app_id="org.kde.ark"] floating enable
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

    # ScratchPad - Dropdown Windows
    #
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

    assign [app_id="kitty"] 1
    assign [app_id="firefox"] 2
    assign [app_id="org.qutebrowser.qutebrowser"] 2
    assign [app_id="dolphin"] 4
    assign [app_id="veracrypt"] 6
    assign [app_id="Steam"] 7

    output "HDMI-A-1" resolution 1920x1080@144hz position 0,0 adaptive_sync on {
      bg ${wallpaper} fill
    }

    input type:pointer {
      accel_profile flat
    }

    bar {
      swaybar_command waybar
      position top
    }
  ''
