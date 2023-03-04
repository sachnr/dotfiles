{pkgs}: ''
    bindsym mod4+q kill
    bindsym mod1+space exec ${pkgs.rofi-wayland}/bin/rofi -show drun
    bindsym mod4+Return exec kitty
    bindsym mod4+Shift+r reload
    bindsym mod4+f fullscreen toggle
    bindsym mod4+Shift+w exec rofi-wallpaper
    bindsym Mod4+Shift+e exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'

    # Workspace
    bindsym mod4+Tab workspace next
    bindsym mod4+Shift+Tab workspace prev
    bindsym mod4+1 workspace number 1
    bindsym mod4+2 workspace number 2
    bindsym mod4+3 workspace number 3
    bindsym mod4+4 workspace number 4
    bindsym mod4+5 workspace number 5
    bindsym mod4+6 workspace number 6
    bindsym mod4+7 workspace number 7
    bindsym mod4+8 workspace number 8
    bindsym mod4+9 workspace number 9
    bindsym mod4+0 workspace number 10
    bindsym mod4+Shift+1 move container to workspace number 1
    bindsym mod4+Shift+2 move container to workspace number 2
    bindsym mod4+Shift+3 move container to workspace number 3
    bindsym mod4+Shift+4 move container to workspace number 4
    bindsym mod4+Shift+5 move container to workspace number 5
    bindsym mod4+Shift+6 move container to workspace number 6
    bindsym mod4+Shift+7 move container to workspace number 7
    bindsym mod4+Shift+8 move container to workspace number 8
    bindsym mod4+Shift+9 move container to workspace number 9

    # scratchpad
    bindsym mod4+minus scratchpad show
    bindsym mod4+Shift+minus move scratchpad

    # focus
    bindsym mod4+a focus parent
    # with arrow keys
    bindsym mod4+Up focus up
    bindsym mod4+Down focus down
    bindsym mod4+Left focus left
    bindsym mod4+Right focus right
    # with hjkl
    bindsym mod4+h focus left
    bindsym mod4+j focus down
    bindsym mod4+k focus up
    bindsym mod4+l focus right

    # Move
    bindsym mod4+Shift+h move left
    bindsym mod4+Shift+j move down
    bindsym mod4+Shift+k move up
    bindsym mod4+Shift+l move right
    # hjkl
    bindsym mod4+Shift+Down move down
    bindsym mod4+Shift+Left move left
    bindsym mod4+Shift+Right move right
    bindsym mod4+Shift+Up move up

    # Layout
    bindsym mod4+s layout stacking
    bindsym mod4+space focus mode_toggle
    bindsym mod4+t floating toggle
    bindsym mod4+v splitv
    bindsym mod4+b splith
    bindsym mod4+w layout tabbed
    bindsym mod4+e layout toggle split

    # Resize
    bindsym mod4+r mode resize
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

    set $mode_system System (l) lock, (e) logout, (s) suspend, (r) reboot, (Shift+s) shutdown

    mode "$mode_system" {
        bindsym l exec --no-startup-id i3lock-fancy -gp, mode "default"
        bindsym e exec --no-startup-id i3-msg exit, mode "default"
        bindsym s exec --no-startup-id systemctl suspend && i3lock-fancy -gp, mode "default"
        bindsym r exec --no-startup-id systemctl reboot, mode "default"
        bindsym Shift+s exec --no-startup-id systemctl poweroff, mode "default"
        bindsym Return mode "default"
        bindsym Escape mode "default"
    }  

    bindsym mod4+F4 mode "$mode_system"
''
