# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  pkgs,
  lib,
  inputs,
  theme,
  user,
  ...
}: let
  rtl8814au = pkgs.linuxKernel.packages.linux_6_2.rtl8812au.overrideAttrs (_: {
    src = inputs.rtl8812au;
  });
  sessions = pkgs.callPackage ../../pkgs/session.nix {};
  sddm-theme = pkgs.callPackage ../../pkgs/sddmtheme.nix {};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./fontconfig.nix
    ./extra-settings.nix
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
    colors = let
      substr = str: lib.strings.removePrefix "#" str;
    in
      with theme.colors; [
        (substr black)
        (substr red)
        (substr green)
        (substr yellow)
        (substr blue)
        (substr purple)
        (substr aqua)
        (substr gray)
        (substr brightblack)
        (substr brightred)
        (substr brightgreen)
        (substr brightyellow)
        (substr brightblue)
        (substr brightpurple)
        (substr brightaqua)
        (substr brightgray)
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
      forceFullCompositionPipeline = true;
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
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "users"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;

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
      pulseaudio
      ntfs3g
      alsa-utils
      usbutils
      ffmpeg

      # compression
      p7zip
      unrar
      unzip
      exfat
      zip

      sddm-theme
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
      xrandrHeads = [
        {
          output = "HDMI-0";
          primary = true;
          monitorConfig = "Option \"PreferredMode\" \"1920x1080@144.0\"";
        }
      ];
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
          theme = "Psion";
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
