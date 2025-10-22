{ theme, pkgs, lib, ... }:
let rp = str: lib.strings.removePrefix "#" str;
in with theme.colors; ''
  ################
  ### MONITORS ###
  ################

  # See https://wiki.hyprland.org/Configuring/Monitors/
  monitor= HDMI-1, 2560x1440@144, 0x0, 1
  monitor= eDP-1 ,1920x1200@60, 2560x0, 1

  ###################
  ### MY PROGRAMS ###
  ###################

  # See https://wiki.hyprland.org/Configuring/Keywords/

  # Set programs that you use
  $terminal = foot
  $fileManager = pcmanfm
  $menu = rofi -show drun


  #################
  ### AUTOSTART ###
  #################

  # Autostart necessary processes (like notifications daemons, status bars, etc.)
  # Or execute your favorite apps at launch like this:

  # exec-once = $terminal
  # exec-once = nm-applet &
  # exec-once = waybar & hyprpaper & firefox
  exec = pkill waybar;waybar
  exec = pkill wpaperd;wpaperd
  # exec= i3status-rs ~/.config/i3status/config.toml
  exec-once = nm-applet --indicator
  exec-once = blueman-applet
  # exec-once = ~/.local/bin/ghostty --gtk-single-instance=true --quit-after-last-window-closed=false --initial-window=false

  #############################
  ### ENVIRONMENT VARIABLES ###
  #############################

  # See https://wiki.hyprland.org/Configuring/Environment-variables/

  env = XCURSOR_SIZE,24
  env = HYPRCURSOR_SIZE,24
  env = NIXOS_OZONE_WL,1

  #####################
  ### LOOK AND FEEL ###
  #####################

  # Refer to https://wiki.hyprland.org/Configuring/Variables/

  # https://wiki.hyprland.org/Configuring/Variables/#general
  general { 
      gaps_in = 8
      gaps_out = 10
      border_size = 2

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      col.active_border=rgba(${rp primary.accent}ff) 
      col.inactive_border=rgba(${rp primary.background}ff)

      # Set to true enable resizing windows by clicking and dragging on borders and gaps
      resize_on_border = false 
      no_focus_fallback = true

      # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
      allow_tearing = false

      layout = dwindle
  }

  # https://wiki.hyprland.org/Configuring/Variables/#decoration
  decoration {
      rounding = 4

      # Change transparency of focused and unfocused windows
      active_opacity = 1.0
      inactive_opacity = 1.0

      shadow {
          enabled = true
          range = 4
          render_power = 3
          color = rgba(1a1a1aee)
      }

      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur {
          enabled            = true
          size               = 4      
          passes             = 2       
          new_optimizations  = true
          ignore_opacity     = true
          xray               = true
          noise              = 0.020   
          contrast           = 0.85    
          brightness         = 0.80    
          vibrancy           = 0.22    
      }
  }

  # https://wiki.hyprland.org/Configuring/Variables/#animations
  animations {
      enabled = yes, please :)

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = easeOutQuint,0.23,1,0.32,1
      bezier = easeInOutCubic,0.65,0.05,0.36,1
      bezier = linear,0,0,1,1
      bezier = almostLinear,0.5,0.5,0.75,1.0
      bezier = quick,0.15,0,0.1,1

      animation = global, 1, 10, default
      animation = border, 1, 5.39, easeOutQuint
      animation = windows, 1, 4.79, easeOutQuint
      animation = windowsIn, 1, 4.1, easeOutQuint, popin 87%
      animation = windowsOut, 1, 1.49, linear, popin 87%
      animation = fadeIn, 1, 1.73, almostLinear
      animation = fadeOut, 1, 1.46, almostLinear
      animation = fade, 1, 3.03, quick
      animation = layers, 1, 3.81, easeOutQuint
      animation = layersIn, 1, 4, easeOutQuint, fade
      animation = layersOut, 1, 1.5, linear, fade
      animation = fadeLayersIn, 1, 1.79, almostLinear
      animation = fadeLayersOut, 1, 1.39, almostLinear
      animation = workspaces, 1, 1.94, almostLinear, fade
      animation = workspacesIn, 1, 1.21, almostLinear, fade
      animation = workspacesOut, 1, 1.94, almostLinear, fade
  }

  # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
  dwindle {
      pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = true # You probably want this
  }

  # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
  master {
      new_status = master
  }

  # https://wiki.hyprland.org/Configuring/Variables/#misc
  misc { 
      force_default_wallpaper = 0 # Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo = true # If true disables the random hyprland logo / anime girl background. :(
  }

  binds {
    workspace_back_and_forth = true
  }

  #############
  ### INPUT ###
  #############

  # https://wiki.hyprland.org/Configuring/Variables/#input
  input {
      kb_layout = us
      kb_variant =
      kb_model =
      kb_options =
      kb_rules =

      follow_mouse = 1

      sensitivity = 0

      accel_profile=flat
      force_no_accel=true

      repeat_delay = 300
      repeat_rate = 50

      touchpad {
          natural_scroll = false
          tap-to-click = false
          disable_while_typing = true
      }
  }

  # https://wiki.hyprland.org/Configuring/Variables/#gestures
  gestures {
      # workspace_swipe = true
  }

  # Example per-device config
  # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
  # device {
  #     name = epic-mouse-v1
  #     sensitivity = -0.5
  # }

  cursor { 
    hide_on_key_press = true
  }

  ####################
  ##### Plugins ######
  ####################

  plugin {
  }

  ####################
  ### KEYBINDINGSS ###
  ####################

  # See https://wiki.hyprland.org/Configuring/Keywords/
  $mainMod = SUPER # Sets "Windows" key as main modifier

  # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
  bind = $mainMod, RETURN, exec, $terminal
  bind = $mainMod, q, killactive,
  bind = ALT, SPACE, exec, $menu
  bind = $mainMod, F4, exit,
  bind = $mainMod, t, togglefloating,
  bind = $mainMod, P, pseudo, # dwindle
  bind = $mainMod, D, togglesplit, # dwindle
  bind = ,Print, exec, grim -g "$(slurp -d)" - | wl-copy
  # bind = ,Print,exec,grim -t png -g slurp ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png
  bind = $mainMod, F2, exec, hyprlock
  bind = $mainMod, f, fullscreen,0
  bind = $mainMod SHIFT, r, exec, hyprctl reload
  bind = $mainMod , TAB, workspace, previous

  # Move focus with mainMod + hjkl
   bind = $mainMod, H, movefocus, l
   bind = $mainMod, L, movefocus, r
   bind = $mainMod, K, movefocus, u
   bind = $mainMod, J, movefocus, d

  # Move focus with mainMod + hjkl
   bind = $mainMod SHIFT, H, movewindow, l
   bind = $mainMod SHIFT, L, movewindow, r
   bind = $mainMod SHIFT, K, movewindow, u
   bind = $mainMod SHIFT, J, movewindow, d

  # Switch workspaces with mainMod + [0-9]
  bind = $mainMod, 1, workspace, 1
  bind = $mainMod, 2, workspace, 2
  bind = $mainMod, 3, workspace, 3
  bind = $mainMod, 4, workspace, 4
  bind = $mainMod, 5, workspace, 5
  bind = $mainMod, 6, workspace, 6
  bind = $mainMod, 7, workspace, 7
  bind = $mainMod, 8, workspace, 8
  bind = $mainMod, 9, workspace, 9
  bind = $mainMod, 0, workspace, 10

  # Move active window to a workspace with mainMod + SHIFT + [0-9]
  bind = $mainMod SHIFT, 1, movetoworkspace, 1
  bind = $mainMod SHIFT, 2, movetoworkspace, 2
  bind = $mainMod SHIFT, 3, movetoworkspace, 3
  bind = $mainMod SHIFT, 4, movetoworkspace, 4
  bind = $mainMod SHIFT, 5, movetoworkspace, 5
  bind = $mainMod SHIFT, 6, movetoworkspace, 6
  bind = $mainMod SHIFT, 7, movetoworkspace, 7
  bind = $mainMod SHIFT, 8, movetoworkspace, 8
  bind = $mainMod SHIFT, 9, movetoworkspace, 9
  bind = $mainMod SHIFT, 0, movetoworkspace, 10

  # Example special workspace (scratchpad)
  bind = $mainMod, S, togglespecialworkspace, magic
  bind = $mainMod SHIFT, S, movetoworkspace, special:magic

  # Scroll through existing workspaces with mainMod + scroll
  bind = $mainMod, mouse_down, workspace, e+1
  bind = $mainMod, mouse_up, workspace, e-1

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow
  bind = SUPERCONTROL, H, resizeactive, -20 0
  bind = SUPERCONTROL, L, resizeactive, 20 0
  bind = SUPERCONTROL, K, resizeactive, 0 -20
  bind = SUPERCONTROL, J, resizeactive, 0 20


  # Laptop multimedia keys for volume and LCD brightness
  bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
  bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
  bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
  bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
  bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
  bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

  # Requires playerctl
  bindl = , XF86AudioNext, exec, playerctl next
  bindl = , XF86AudioPause, exec, playerctl play-pause
  bindl = , XF86AudioPlay, exec, playerctl play-pause
  bindl = , XF86AudioPrev, exec, playerctl previous


  ##############################
  ### WINDOWS AND WORKSPACES ###
  ##############################

  # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
  # See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

  # Example windowrule v1
  # windowrule = float, ^(kitty)$

  # Example windowrule v2
  # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

  windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
  windowrulev2=float,class:^(GtkFileChooserDialog)$,title:^(Open File)$|^(Save File)$|^(Preferences)$
  windowrulev2=float,class:^(nm-connection-editor)$
  windowrulev2=float,class:^(lxappearance)$
  windowrulev2=float,class:^(Pavucontrol)$
  windowrulev2=float,class:^(ark)$|^(Ark)$
  windowrulev2=noanim,class:^(Brave-browser)$
  windowrulev2=noblur,class:^(Brave-browser)$
  windowrulev2=noblur,class:^(Firefox)$
  windowrulev2=noblur,class:^()$,title:^()$
  windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
  windowrulev2 = opacity 1.0,class:^(com.mitchellh.ghostty)$
''
