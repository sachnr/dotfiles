_: ''
    bindsym mod4+q kill
    bindsym alt+space exec rofi -show drun
    bindsym mod4+Return exec kitty
    bindsym mod4+Shift+r reload
    bindsym mod4+f fullscreen toggle

    # Workspace
    bindsym mod4+1 workspace number 1
    bindsym mod4+2 workspace number 2
    bindsym mod4+3 workspace number 3
    bindsym mod4+4 workspace number 4
    bindsym mod4+5 workspace number 5
    bindsym mod4+6 workspace number 6
    bindsym mod4+7 workspace number 7
    bindsym mod4+8 workspace number 8
    bindsym mod4+9 workspace number 9
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

  bindsym mod4+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'
''
