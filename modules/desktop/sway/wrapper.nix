{pkgs}: ''
  # nvidia
  export WLR_NO_HARDWARE_CURSORS=1
  export GBM_BACKEND=nvidia-drm
  export __GLX_VENDOR_LIBRARY_NAME=nvidia
  export LIBVA_DRIVER_NAME=nvidia
  export VDPAU_DRIVER=nvidia
  export __GL_VRR_ALLOWED=0
  export WLR_DRM_NO_ATOMIC=1
  export EGL_PLATFORM=wayland

  # Can cause flickering
  # export WLR_BACKEND=vulkan

  # session
  export XDG_SESSION_TYPE=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway

  #qt
  export QT_AUTO_SCREEN_SCALE_FACTOR=1
  export QT_QPA_PLATFORM=wayland
  export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  export QT_QPA_PLATFORMTHEME=qt5ct

  # Toolkit Backend Variables
  export _JAVA_AWT_WM_NONEREPARENTING=1
  export SDL_VIDEODRIVER=wayland
  export CLUTTER_BACKEND=wayland
  export GDK_BACKEND="wayland,x11"
  export NIXOS_OZONE_WL=1

  # firefox
  export MOZ_ENABLE_WAYLAND=1
  export QUTE_SKIP_NOUVEAU_CHECK=1
''
