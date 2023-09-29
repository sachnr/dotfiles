{pkgs, ...}: let
  sessions = pkgs.callPackage ../../pkgs/session.nix {};
  sddm-theme = pkgs.callPackage ../../pkgs/sddmtheme.nix {};
in {
  programs.zsh.enable = true;

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      pulseaudio
      ntfs3g
      alsa-utils
      usbutils
      ffmpeg
      p7zip
      unrar
      unzip
      exfat
      zip
      gnome.gvfs
      sddm-theme
    ];

    pathsToLink = ["/share/zsh"];
  };

  # polkit
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock.text = ''
      # Account management.
      account required pam_unix.so

      # Authentication management.
      auth sufficient pam_unix.so   likeauth try_first_pass
      auth required pam_deny.so

      # Password management.
      password sufficient pam_unix.so nullok sha512

      # Session management.
      session required pam_env.so conffile=/etc/pam/environment readenv=0
      session required pam_unix.so
    '';
  };

  # List services that you want to enable:
  services = {
    blueman.enable = true;
    fstrim.enable = true;
    dbus.enable = true;
    # openssh.enable = true;
    # printing.enable = true;
  };

  # Enable display manager
  services.xserver = {
    enable = true;
    # xrandrHeads = [
    #   {
    #     output = "HDMI-0";
    #     primary = true;
    #   }
    # ];
    layout = "us";
    videoDrivers = ["nvidia"];
    desktopManager = {
      xfce.enable = false;
    };
    windowManager = {
      awesome = {
        enable = true;
        luaModules = with pkgs.extraLuaPackages; [
          pkgs.luajitPackages.lgi
          dbus_proxy
          pulseaudio_dbus
        ];
      };
    };
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      startx.enable = true;
      sddm = {
        enable = true;
        theme = "Psion";
      };
      sessionPackages = [sessions];
      sessionCommands = ''
        ${pkgs.xorg.xset}/bin/xset r rate 250 25
      '';
      lightdm.enable = false;
    };
    libinput = {
      enable = true;
      mouse.accelProfile = "flat";
      mouse.accelSpeed = "0";
      touchpad.naturalScrolling = true;
    };
  };

  services.pipewire = {
    enable = true;
    audio.enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber.enable = true;
    pulse.enable = true;
    jack.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-wlr
    ];
  };
}
