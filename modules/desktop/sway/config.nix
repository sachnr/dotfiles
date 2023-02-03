{
  pkgs,
  theme,
  ...
}: let
in
  with theme.colors; ''
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

    for_window [class="GtkFileChooserDialog"] floating enable
    for_window [window_role="pop-up"] floating enable
    for_window [window_role="task_dialog"] floating enable
    for_window [class="Pavucontrol"] floating enable
    for_window [class="nm-connection-editor"] floating enable
    for_window [class="lxappearance"] floating enable
    for_window [class="blueman-manager"] floating enable
    for_window [class="^(ark)$|^(Ark)$"] floating enable
    for_window [title="Steam Guard"] floating enable
    for_window [class="steam_app*"] inhibit_idle focus
    for_window [class="steam_app*"] max_render_time 3

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

    exec ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY I3SOCK SWAYSOCK WAYLAND_DISPLAY XDG_CURRENT_DESKTOP XDG_SESSION_TYPE && systemctl --user start sway-session.target
    exec ${pkgs.blueman}/bin/blueman-applet
    exec ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator 
  ''
