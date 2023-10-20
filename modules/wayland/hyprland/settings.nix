{
  theme,
  pkgs,
  lib,
}:
with theme; let
  rp = str: lib.strings.removePrefix "#" str;
in ''
  env=WLR_NO_HARDWARE_CURSORS,1
  env=GDK_BACKEND,wayland,x11
  env=QT_QPA_PLATFORM,"wayland;xcb"
  env=SDL_VIDEODRIVER,wayland
  env=CLUTTER_BACKEND,wayland
  env=XDG_CURRENT_DESKTOP,Hyprland
  env=XDG_SESSION_TYPE,wayland
  env=XDG_SESSION_DESKTOP,Hyprland
  env=QT_AUTO_SCREEN_SCALE_FACTOR,1
  env=QT_QPA_PLATFORM,wayland;xcb
  env=QT_WAYLAND_DISABLE_WINDOWDECORATION,1
  env=QT_QPA_PLATFORMTHEME,qt5ct
  env=GBM_BACKEND,nvidia-drm
  env=__GLX_VENDOR_LIBRARY_NAME,nvidia
  env=LIBVA_DRIVER_NAME,nvidia
  env=MOZ_ENABLE_WAYLAND,1
  env=__GL_VRR_ALLOWED,0
  env=WLR_DRM_NO_ATOMIC,1

  exec-once =  "${pkgs.dbus}/bin/dbus-update-activation-environment --systemd DISPLAY HYPRLAND_INSTANCE_SIGNATURE WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user start hyprland-session.target"

  monitor=DP-1, 1920x1080@144, 0x0, 1
  monitor=HDMI-A-1, 1920x1080@144, 1920x0, 1

  general {
    col.active_border=rgb(${rp red}) rgb(${rp green}) rgb(${rp blue}) 270deg
    col.inactive_border=rgba(${rp background}ff)
    border_size=1
    gaps_in=2
    gaps_out=2
    layout=dwindle
  }

  decoration {
    blur {
        enabled=true
        new_optimizations=true
        passes=1
        size=6
    }
    col.shadow=rgba(${rp background}70)
    drop_shadow=true
    fullscreen_opacity=1
    rounding=1
    shadow_ignore_window=true
    shadow_offset=4 6
    shadow_range=8
    shadow_render_power=2
  }

  dwindle {
    force_split=2
    preserve_split=yes
    pseudotile=yes
    use_active_for_splits=true
  }

  bezier=linear, 0.0, 0.0, 1.0, 1.0
  bezier=overshot,0.05,0.9,0.1,1.1

  animations {
    animation=workspaces,1,2,overshot,fade
    animation=windows,1,2,linear,popin
    animation=border,1,14,default
    animation=borderangle, 1, 100, linear, loop
    enabled=true
  }

  gestures {
    workspace_swipe=off
  }

  input {
    accel_profile=flat
    follow_mouse=1
    force_no_accel=true
    sensitivity=0
  }

  master {
    new_is_master=true
  }

  misc {
    disable_hyprland_logo=true
    disable_splash_rendering=true
    mouse_move_enables_dpms=true
    vfr=false
  }

  $mainMod=SUPER

  bind=$mainMod, q, killactive,
  bind=$mainMod, RETURN, exec, foot
  bind=ALT, SPACE, exec, rofi -show drun
  bind=$mainModSHIFT, r, exec, hyprctl reload
  bind=$mainMod, F2, exec, swaylock --daemonize
  bind=,Print,exec,grim -t png -g "$(slurp)" ~/Pictures/$(date +%Y-%m-%d_%H-%m-%s).png
  bind=$mainMod, comma, movecurrentworkspacetomonitor, 1
  bind=$mainMod, period, movecurrentworkspacetomonitor, 0
  bind=$mainMod, t, togglefloating
  bind=$mainMod, y, pseudo
  bind=$mainMod, left, movefocus, l
  bind=$mainMod, right, movefocus, r
  bind=$mainMod, up, movefocus, u
  bind=$mainMod, down, movefocus, d
  bind=$mainMod, H, movefocus, l
  bind=$mainMod, L, movefocus, r
  bind=$mainMod, K, movefocus, u
  bind=$mainMod, J, movefocus, d
  bind=SUPERSHIFT, left, movewindow,l
  bind=SUPERSHIFT, right, movewindow,r
  bind=SUPERSHIFT, up, movewindow,u
  bind=SUPERSHIFT, down, movewindow,d
  bind=SUPERSHIFT, H, movewindow,l
  bind=SUPERSHIFT, L, movewindow,r
  bind=SUPERSHIFT, K, movewindow,u
  bind=SUPERSHIFT, J, movewindow,d
  bind=SUPERCONTROL, left, resizeactive, -20 0
  bind=SUPERCONTROL, right, resizeactive, 20 0
  bind=SUPERCONTROL, up, resizeactive, 0 -20
  bind=SUPERCONTROL, down, resizeactive, 0 10
  bind=SUPERCONTROL, H, resizeactive, -20 0
  bind=SUPERCONTROL, L, resizeactive, 20 0
  bind=SUPERCONTROL, K, resizeactive, 0 -20
  bind=SUPERCONTROL, J, resizeactive, 0 20
  bind=$mainMod, f, fullscreen, 0
  bind=$mainMod, 1, workspace, 1
  bind=$mainMod, 2, workspace, 2
  bind=$mainMod, 3, workspace, 3
  bind=$mainMod, 4, workspace, 4
  bind=$mainMod, 5, workspace, 5
  bind=$mainMod, 6, workspace, 6
  bind=$mainMod, 7, workspace, 7
  bind=$mainMod, 8, workspace, 8
  bind=$mainMod, 9, workspace, 9
  bind=$mainMod, 0, workspace, 10
  bind=$mainMod SHIFT, 1, movetoworkspace, 1
  bind=$mainMod SHIFT, 2, movetoworkspace, 2
  bind=$mainMod SHIFT, 3, movetoworkspace, 3
  bind=$mainMod SHIFT, 4, movetoworkspace, 4
  bind=$mainMod SHIFT, 5, movetoworkspace, 5
  bind=$mainMod SHIFT, 6, movetoworkspace, 6
  bind=$mainMod SHIFT, 7, movetoworkspace, 7
  bind=$mainMod SHIFT, 8, movetoworkspace, 8
  bind=$mainMod SHIFT, 9, movetoworkspace, 9
  bind=$mainMod SHIFT, 0, movetoworkspace, 10
  bind=$mainMod, TAB, cyclenext
  bind=$mainMod SHIFT, TAB, cyclenext, prev
  bindm=$mainMod, mouse:272, movewindow
  bindm=$mainMod, mouse:273, resizewindow

  exec=pkill waybar;waybar
  exec=pkill wpaperd;wpaperd
  exec-once=blueman-applet
  exec-once=gammastep-indicator -v
  exec-once=nm-applet --indicator

  windowrule=float,Rofi
  windowrule=float,^(blueman-manager)$
  windowrule=idleinhibit fullscreen,brave
  windowrule=float,Steam Guard
  windowrulev2=float,class:^(GtkFileChooserDialog)$,title:^(Open File)$|^(Save File)$|^(Preferences)$
  windowrulev2=float,class:^(nm-connection-editor)$
  windowrulev2=float,class:^(lxappearance)$
  windowrulev2=float,class:^(Pavucontrol)$
  windowrulev2=float,class:^(ark)$|^(Ark)$
''
