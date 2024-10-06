{ theme, pkgs, lib, ... }:
let rp = str: lib.strings.removePrefix "#" str;
in with theme.colors; ''
  ################
  ### MONITORS ###
  ################

  # See https://wiki.hyprland.org/Configuring/Monitors/
  monitor=,preferred,2560x1440@180,auto
  monitor= DP-3,2560x1440@180, 0x0 ,1


  ###################
  ### MY PROGRAMS ###
  ###################

  # See https://wiki.hyprland.org/Configuring/Keywords/

  # Set programs that you use
  $terminal = alacritty
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
  exec= i3status-rs ~/.config/i3status/config.toml
  exec-once = nm-applet --indicator

  #############################
  ### ENVIRONMENT VARIABLES ###
  #############################

  # See https://wiki.hyprland.org/Configuring/Environment-variables/

  env = XCURSOR_SIZE,24
  env = HYPRCURSOR_SIZE,24
  env = XDG_CURRENT_DESKTOP,Hyprland
  env = XDG_SESSION_TYPE,wayland
  env = XDG_SESSION_DESKTOP,Hyprland
  env = QT_QPA_PLATFORMTHEME,qt5ct
  env = MOZ_ENABLE_WAYLAND,1
  env = LIBVA_DRIVER_NAME,nvidia
  env = GBM_BACKEND,nvidia-drm

  #####################
  ### LOOK AND FEEL ###
  #####################

  # Refer to https://wiki.hyprland.org/Configuring/Variables/

  # https://wiki.hyprland.org/Configuring/Variables/#general
  general { 
      gaps_in = 4
      gaps_out = 6
      border_size = 2

      # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
      col.active_border=rgb(${rp normal.red}) rgb(${rp normal.green}) rgb(${
        rp normal.blue
      }) 270deg
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
      rounding = 10

      # Change transparency of focused and unfocused windows
      active_opacity = 1.0
      inactive_opacity = 1.0

      drop_shadow = true
      shadow_range = 4
      shadow_render_power = 3
      col.shadow=rgba(${rp primary.background}70)


      # https://wiki.hyprland.org/Configuring/Variables/#blur
      blur {
          enabled = true
          size = 3
          passes = 1
          
          vibrancy = 0.1696
      }
  }

  # https://wiki.hyprland.org/Configuring/Variables/#animations
  animations {
      enabled = true

      # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05
      bezier = linear, 0.0, 0.0, 1.0, 1.0

      animation = windows, 1, 7, myBezier
      animation = windowsOut, 1, 7, default, popin 80%
      animation = border, 1, 10, default
      animation = borderangle, 1, 100, linear, loop
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default
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
      force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
      disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
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

      sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

      accel_profile=flat
      force_no_accel=true

      touchpad {
          natural_scroll = false
      }
  }

  # https://wiki.hyprland.org/Configuring/Variables/#gestures
  gestures {
      workspace_swipe = false
  }

  # Example per-device config
  # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
  # device {
  #     name = epic-mouse-v1
  #     sensitivity = -0.5
  # }

  ####################
  ##### Plugins ######
  ####################

  plugin {
      csgo-vulkan-fix {
          res_w = 1920
          res_h = 1200

          # NOT a regex! This is a string and has to exactly match initial_class
          class = cs2

          # Whether to fix the mouse position. A select few apps might be wonky with this.
          fix_mouse = false
      }
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
  bind = ,Print,exec,grim -t png -g "$(slurp)" ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png
  bind = $mainMod, F2, exec, hyprlock
  bind = $mainMod, f, fullscreen,0


  # Move focus with mainMod + arrow keys
  bind = $mainMod, H, movefocus, l
  bind = $mainMod, L, movefocus, r
  bind = $mainMod, K, movefocus, u
  bind = $mainMod, J, movefocus, d

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

  # Resize

  bind = SUPERCONTROL, left, resizeactive, -20 0
  bind = SUPERCONTROL, right, resizeactive, 20 0
  bind = SUPERCONTROL, up, resizeactive, 0 -20
  bind = SUPERCONTROL, down, resizeactive, 0 10
  bind = SUPERCONTROL, H, resizeactive, -20 0
  bind = SUPERCONTROL, L, resizeactive, 20 0
  bind = SUPERCONTROL, K, resizeactive, 0 -20
  bind = SUPERCONTROL, J, resizeactive, 0 20

  # Move/resize windows with mainMod + LMB/RMB and dragging
  bindm = $mainMod, mouse:272, movewindow
  bindm = $mainMod, mouse:273, resizewindow

  bind = $mainMod, TAB, cyclenext
  bind = $mainMod SHIFT, TAB, cyclenext, prev


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
  windowrule=float,Rofi
  windowrule=float,^(blueman-manager)$
  windowrule=idleinhibit fullscreen,brave
  windowrule=float,Steam Guard
  windowrulev2=float,class:^(GtkFileChooserDialog)$,title:^(Open File)$|^(Save File)$|^(Preferences)$
  windowrulev2=float,class:^(nm-connection-editor)$
  windowrulev2=float,class:^(lxappearance)$
  windowrulev2=float,class:^(Pavucontrol)$
  windowrulev2=float,class:^(ark)$|^(Ark)$
  windowrulev2=noanim,class:^(Brave-browser)$
  windowrulev2=noblur,class:^(Brave-browser)$
''
