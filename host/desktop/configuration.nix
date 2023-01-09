# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  rtl8814au = config.boot.kernelPackages.callPackage ../../pkgs/rtl88xxau.nix {};
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    supportedFilesystems = ["ntfs"];
    kernelPackages = pkgs.linuxPackages_latest;
    blacklistedKernelModules = ["nouveau"];
    kernelParams = ["nomodeset"];
    extraModulePackages = [rtl8814au];
    loader = {
      timeout = 5;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        efiSupport = true;
        useOSProber = true;
      };
    };
  };

  networking.hostName = "sachnr-nixos";
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkbOptions in tty.
  };

  # Enable sound.
  sound.enable = true;

  # polkit
  security.polkit.enable = true;

  # Enable pipewire/pulseaudio

  # hardware.pulseaudio = {
  #   enable = true;
  #   support32Bit = true;
  # };

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

  # services.openssh.enable = true;
  # services.printing.enable = true;

  # Enable display manager
  services = {
    xserver = {
      enable = true;
      layout = "us";
      videoDrivers = ["nvidia"];
      displayManager.startx.enable = true;
      desktopManager.xfce.enable = true;
      desktopManager.xterm.enable = true;
      libinput = {
        enable = true;
        mouse.accelProfile = "flat";
        mouse.accelSpeed = "0";
        touchpad.naturalScrolling = true;
      };
      displayManager.sddm = {
        enable = true;
      };
    };

    # greetd = {
    #   enable = true;
    #   package = pkgs.greetd.wlgreet;
    #   settings = rec {
    #     initial_session = {
    #       command = "hyprlandwrapped";
    #       user = "sachnr";
    #     };
    #     default_session = initial_session;
    #   };
    # };
  };

  # nvidia options
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
      nvidia-vaapi-driver
    ];
  };
  hardware.nvidia = {
    open = true;
    powerManagement.enable = true;
    modesetting.enable = true;
  };

  # enable bluetooth
  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };

  # enable dbus
  services.dbus.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sachnr = {
    isNormalUser = true;
    extraGroups = ["wheel" "video" "audio" "networkmanager" "storage"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
  };

  nixpkgs.config = {
    allowUnfree = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      # system
      util-linux
      socat
      lsof
      file
      patchelf
      lm_sensors
      whois
      pulseaudio

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

  # List services that you want to enable:
  services = {
    blueman.enable = true;
    fstrim.enable = true;
    gvfs.enable = true;
  };

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
  system.stateVersion = "22.11"; # Did you read the comment?
}
