{
  user,
  config,
  pkgs,
  lib,
  ...
}: {
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
      less
      btop
      pfetch
      lazygit
      ripgrep
      fd
      yt-dlp

      # General
      networkmanagerapplet
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
      # nodePackages.vue-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      rnix-lsp
      sqls
      ccls

      # Dev
      rustup
      python39
      jdk
      git
      nodePackages.npm
      yarn
      nodejs
      # deno
      jq
      gcc
      # go

      # debugger
      gdb

      # Formatters
      black
      shfmt
      stylua
      astyle
      nodePackages.prettier
      alejandra

      # Build tools
      maven
      cmake
    ];
  };
}
