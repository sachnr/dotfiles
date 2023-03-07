{
  pkgs,
  theme,
}:
with theme.colors; ''
    font pango:monospace 8.000000
    floating_modifier Mod4
    default_floating_border 1pixel
    gaps inner 6
    gaps outer 2
    hide_edge_borders none
    focus_wrapping yes
    focus_follows_mouse yes
    focus_on_window_activation focus
    mouse_warping output
    workspace_layout default
    workspace_auto_back_and_forth no
    tiling_drag modifier

    # class        border backgr. text indicator child_border
    client.focused ${blue} ${black} ${foreground} ${brightblue} ${blue}
    client.focused_inactive ${background} ${background} ${foreground} ${brightblue} ${blue}
    client.unfocused ${background} ${background} ${gray} ${selection} ${black}
    client.urgent ${red} ${background} ${foreground} ${brightblack} ${black}
    client.placeholder ${background} ${background} ${foreground} ${brightblue} ${black}
    client.background ${foreground}

   bar {
   font pango:Roboto, Symbols Nerd Font Mono 10
   mode dock
   hidden_state hide
   position top
   status_command ${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-default.toml
   i3bar_command ${pkgs.i3}/bin/i3bar
   workspace_buttons yes
   strip_workspace_numbers no
   tray_output primary
   colors {
       background ${black}
       statusline ${foreground}
       separator ${gray}
       focused_workspace ${brightblue} ${blue} ${black}
       active_workspace ${background} ${brightgray} ${foreground}
       inactive_workspace ${background} ${black} ${gray}
       urgent_workspace ${background} ${brightred} ${foreground}
       binding_mode ${background} ${brightred} ${foreground}
       }
   }

    exec ${pkgs.blueman}/bin/blueman-applet
    exec ${pkgs.networkmanagerapplet}/bin/nm-applet --indicator
    exec ${pkgs.picom-git}/bin/picom
    exec ${pkgs.feh}/bin/feh --bg-scale ${wallpaper}
''
