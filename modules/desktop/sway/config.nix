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
    default_floating_border pixel 2
    hide_edge_borders none
    focus_wrapping no
    focus_follows_mouse yes
    focus_on_window_activation smart
    mouse_warping output
    workspace_layout default
    workspace_auto_back_and_forth no
    # class        border backgr. text indicator child_border
    client.focused #4c7899 #285577 #ffffff #2e9ef4 #285577
    client.focused_inactive #333333 #5f676a #ffffff #484e50 #5f676a
    client.unfocused #333333 #222222 #888888 #292d2e #222222
    client.urgent #2f343a #900000 #ffffff #900000 #900000
    client.placeholder #000000 #0c0c0c #ffffff #000000 #0c0c0c
    client.background #ffffff

    output "HDMI-A-1" {
      bg ${wallpaper} fill
    }

    exec ${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP XDG_SESSION_TYPE; systemctl --user start sway-session.target
    exec ${pkgs.waybar}/bin/waybar
  ''
