{ pkgs, ... }:
let
  network-driver = let
    getPackage = pname: pkgs:
      (pkgs.callPackage ../../_sources/generated.nix { }).${pname};
    driver = getPackage "rtl88x2bu" pkgs;
  in pkgs.linuxKernel.packages.linux_6_11.rtl88x2bu.overrideAttrs
  (prev: { src = driver.src; });
in {
  imports = [ ./hardware-configuration.nix ];

  boot = {
    supportedFilesystems = [ "ntfs" ];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = [ "nouveau" ];
    kernelParams = [ "quiet" "fbdev=1" ];
    extraModulePackages = [ network-driver ];
    extraModprobeConfig = ''
      options nvidia NVreg_RegistryDwords="PowerMizerEnable=0x1; PerfLevelSrc=0x2222; PowerMizerLevel=0x3; PowerMizerDefault=0x3; PowerMizerDefaultAC=0x3;"
    '';
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        gfxmodeEfi = "2560x1440";
        devices = [ "nodev" ];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
      };
    };
  };

  networking = {
    nameservers = [ "1.1.1.1" ];
    hostName = "sachnr-nixos";
    networkmanager = {
      enable = true; # Easiest to use and most distros use this by default.
    };
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # extraHosts = import ./blocklist.nix;
  };

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  environment = {
    sessionVariables = {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      pulseaudio
      alsa-utils
      ntfs3g
      usbutils
      bluez
      libappindicator-gtk3
    ];

    pathsToLink = [ "/share/zsh" "/share/icons" ];
  };

  hardware = {
    graphics = { enable = true; };
    nvidia = {
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      forceFullCompositionPipeline = true;
      open = true;
      nvidiaSettings = true;
      modesetting.enable = true;
      # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
      #   version = "555.58.02";
      #   sha256_64bit = "sha256-xctt4TPRlOJ6r5S54h5W6PT6/3Zy2R4ASNFPu8TSHKM=";
      #   sha256_aarch64 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
      #   openSha256 = "sha256-8hyRiGB+m2hL3c9MDA/Pon+Xl6E788MZ50WrrAGUVuY=";
      #   settingsSha256 = "sha256-ZpuVZybW6CFN/gz9rx+UJvQ715FZnAOYfHn5jt5Z2C8=";
      #   persistencedSha256 =
      #     "sha256-a1D7ZZmcKFWfPjjH1REqPM5j/YLWKnbkP9qfRyIyxAw=";
      # };
      # package = pkgs.linuxKernel.packages.linux_zen.nvidia_x11;
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

  services.autorandr = {
    enable = true;
    profiles = {
      "home" = {
        fingerprint = {
          DP-4 =
            "00ffffffffffff0004726a0c000000000e210104b53c22783b29d5ad4f44a7240f5054bfef00d1c081803168317c4568457c6168617c565e00a0a0a029503020350055502100001e000000ff0031333232313331323331323333000000fc005856323732552056330a202020000000fd0c30b4090947010a202020202020020a020335f14c0103051404131f120211903f2309070783010000e200d5e305c301e606050161611c6d1a0000020130b400000000000098fc006aa0a01e500820350055502100001a40e7006aa0a067500820980455502100001a6fc200a0a0a055503020350055502100001ef03c00d051a0355060883a0055502100001c0000397012790300030114c7130184ff096d0007801f009f051d000200040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001990";
        };
        config = {
          DP-4 = {
            enable = true;
            crtc = 0;
            primary = true;
            position = "0x0";
            mode = "2560x1440";
            gamma = "1.0:0.909:0.833";
            rate = "179.88";
            rotate = "normal";
          };
        };
      };
    };
  };

  services.udev.extraRules = ''
    ACTION=="change", SUBSYSTEM=="drm", RUN+="${pkgs.autorandr}/bin/autorandr -c"'';

  # Enable display manager
  services.xserver = {
    enable = true;
    dpi = 108;
    xkb = { layout = "us"; };
    videoDrivers = [ "nvidia" ];
    displayManager = { gdm = { enable = true; }; };
  };

  services.displayManager = {
    # sddm = { enable = true; };
    sessionPackages = [ ];
  };

  services.libinput = {
    enable = true;
    mouse.accelProfile = "flat";
    mouse.accelSpeed = "0";
    touchpad.naturalScrolling = true;
  };

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    wireplumber.enable = true;
    pulse.enable = true;
  };

  systemd.user.services.pipewire-pulse.path = [ pkgs.pulseaudio ];

  nix = {
    package = pkgs.nixVersions.stable;
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It’s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
