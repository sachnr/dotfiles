# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  rtl8814au = pkgs.linuxKernel.packages.linux_6_2.rtl8812au.overrideAttrs (_: {
    src = pkgs.fetchFromGitHub {
      owner = "aircrack-ng";
      repo = "rtl8812au";
      rev = "d98018d038a5db96066e79f26ed4a72f2fe1774e";
      sha256 = "sha256-R+DDdM8mkuAimgI/OCp927LEb4jX9tgf2lmbXFArqtY=";
    };
  });
  sessions = pkgs.callPackage ../../pkgs/session.nix {};
  sddm-theme = pkgs.callPackage ../../pkgs/sddmtheme.nix {};
  theme = import ../../theme {};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    supportedFilesystems = ["ntfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = ["nouveau" "i2c_nvidia_gpu"];
    kernelParams = ["quiet"];
    extraModulePackages = [rtl8814au];
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        gfxmodeEfi = "1920x1080";
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
        default = "saved";
      };
    };
  };

  networking = {
    hostName = "sachnr-nixos";
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    # keyMap = "us";
    packages = with pkgs; [terminus_font];
    font = "ter-u28b";
    useXkbConfig = true; # use xkbOptions in tty.
    earlySetup = true;
    colors = with theme.colors; [
      (builtins.substring 1 6 black)
      (builtins.substring 1 6 red)
      (builtins.substring 1 6 green)
      (builtins.substring 1 6 yellow)
      (builtins.substring 1 6 blue)
      (builtins.substring 1 6 purple)
      (builtins.substring 1 6 aqua)
      (builtins.substring 1 6 gray)
      (builtins.substring 1 6 brightblack)
      (builtins.substring 1 6 brightred)
      (builtins.substring 1 6 brightgreen)
      (builtins.substring 1 6 brightyellow)
      (builtins.substring 1 6 brightblue)
      (builtins.substring 1 6 brightpurple)
      (builtins.substring 1 6 brightaqua)
      (builtins.substring 1 6 brightgray)
    ];
  };

  # Enable sound.
  sound.enable = true;

  hardware = {
    pulseaudio.enable = false;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        nvidia-vaapi-driver
      ];
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
    };
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sachnr = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "users"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    sessionVariables = rec {
      QT_QPA_PLATFORMTHEME = "qt5ct";
      EDITOR = "nvim";
    };

    systemPackages = with pkgs; [
      # system
      socat
      lsof
      file
      glibc
      patchelf
      lm_sensors
      whois
      pulseaudio
      nix-index
      sddm-theme

      ntfs3g
      alsa-utils
      usbutils
      ffmpeg

      # compression
      p7zip
      unzip
      exfat
      zip

      #vulcan/opengl
      glxinfo
      vulkan-tools
      glmark2
    ];
  };

  # polkit
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };

  # List services that you want to enable:
  services = {
    blueman.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
    dbus.enable = true;
  };

  # services.openssh.enable = true;
  # services.printing.enable = true;

  # Enable display manager
  services = {
    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = ["nvidia"];
      desktopManager = {
        xfce.enable = false;
      };
      windowManager = {
        awesome = {
          enable = true;
        };
      };
      desktopManager = {
        xterm.enable = false;
      };
      displayManager = {
        startx.enable = true;
        sddm = {
          enable = true;
          theme = "maldives";
        };
        sessionPackages = [sessions];
        lightdm.enable = false;
      };
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0";
        touchpad.naturalScrolling = true;
      };
    };
    # greetd = {
    #   enable = true;
    #   package = pkgs.greetd.tuigreet;
    #   vt = 2;
    #   settings = {
    #     default_session = {
    #       user = "sachnr";
    #       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway --remember --remember-session --user-menu";
    #     };
    #   };
    # };
    # sound
    pipewire = {
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
  };

  environment.pathsToLink = ["/share/zsh"];

  # Enable the OpenSSH daemon.

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
