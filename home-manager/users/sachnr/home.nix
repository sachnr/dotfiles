{
  user,
  config,
  pkgs,
  lib,
  ...
}: let
  themix = pkgs.callPackage ../../../pkgs/themix-gui.nix {};
in {
  programs = {
    obs-studio.enable = false;
    less.enable = true;
    java.enable = true;
  };

  services.network-manager-applet.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home = {
    username = "sachnr";
    homeDirectory = "/home/sachnr";
    stateVersion = "22.11";

    packages = with pkgs; [
      # Terminal
      ranger
      btop
      pfetch
      lazygit
      ripgrep
      fd
      yt-dlp

      # General
      networkmanagerapplet
      blueberry
      veracrypt

      # media
      feh
      pavucontrol
      steam

      # File Manager
      # gnome.file-roller
      # gnome.nautilus
      # gnome.nautilus-python
      # nautilus-open-any-terminal
      libsForQt5.dolphin-plugins
      libsForQt5.dolphin
      libsForQt5.kservice
      libsForQt5.kio
      libsForQt5.kio-extras
      libsForQt5.kdegraphics-thumbnailers
      libsForQt5.ark
      ghostscript

      # Browsers
      ungoogled-chromium
      tor-browser-bundle-bin

      # Downloader
      qbittorrent
      wget
      aria

      # Language Servers
      sumneko-lua-language-server
      rust-analyzer
      python39Packages.python-lsp-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.vue-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      rnix-lsp
      statix
      sqls
      ccls

      # Dev
      rustup
      python39
      git
      nodePackages.npm
      yarn
      nodejs
      deno
      jq
      gcc
      gdb
      # go

      # Formatters
      black
      shfmt
      stylua
      astyle
      nodePackages.prettier
      alejandra

      # Build tools
      maven
    ];
  };
}
