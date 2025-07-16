{ pkgs, ... }: {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ ];
    kernelParams =
      [ "quiet" "mem_sleep_default=deep" "pcie_aspm.policy=powersupersave" ];
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        gfxmodeEfi = "1920x1200";
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
      };
    };
  };

  networking = {
    hostName = "thinkpad";
    networkmanager.enable =
      true; # Easiest to use and most distros use this by default.
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "gtk3";
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      pulseaudio
      alsa-utils
      ntfs3g
      usbutils
      bluez
      sof-firmware
    ];

    pathsToLink = [ "/share/zsh" ];
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl amdvlk ];
    };
    bluetooth = {
      enable = true;
      settings = { General = { Enable = "Source,Sink,Media,Socket"; }; };
    };
  };

  # polkit
  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.i3lock.text = ''
      # Account management.
      account required pam_unix.so

      # Authentication management.
      auth required pam_unix.so nullok_secure

      # Password management.
      password required pam_unix.so nullok sha512

      # Session management.
      session required pam_env.so conffile=/etc/pam/environment readenv=0
      session required pam_unix.so
    '';
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

  services.xserver = {
    enable = true;
    dpi = 96;
    xkb = { layout = "us"; };
    videoDrivers = [ "amdgpu" ];
  };

  services.displayManager = {
    gdm = { enable = true; };
    sessionPackages = [ ];
  };

  services.libinput = {
    enable = true;
    mouse = {
      accelProfile = "flat";
      accelSpeed = "0";
    };
    touchpad = {
      disableWhileTyping = true;
      tapping = false;
    };
  };

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    wireplumber.enable = true;
    pulse.enable = true;
  };

  # services.tlp = {
  #   enable = true;
  #   settings = {
  #     CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #     CPU_SCALING_GOVERNOR_ON_BAT = "conservative";
  #   };
  # };

  services.upower.enable = true;

  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  networking.firewall.enable = true;
  networking.firewall.allowPing = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It’s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
