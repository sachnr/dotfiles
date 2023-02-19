{
  inputs,
  pkgs,
  system,
  user,
  ...
}: {
  home = {
    username = "sachnr";
    homeDirectory = "/home/sachnr";
    stateVersion = "22.11";

    packages = with pkgs; [
      # Terminal
      ranger
      btop
      pfetch
      gitui
      ripgrep
      fd
      youtube-dl

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
      python311Packages.python-lsp-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.vue-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint_d
      nodePackages.eslint
      efm-langserver
      rnix-lsp
      statix
      sqls
      ccls

      # Dev
      python311Full
      nodePackages.typescript
      git
      nodePackages.npm
      yarn
      nodejs
      deno
      jq
      gcc
      gdb
      go

      # Formatters
      black
      shfmt
      stylua
      astyle
      nodePackages.prettier
      alejandra

      # Build tools
      automake
      gnumake
      maven
      pkg-config
      clang-tools
      cmake
      ninja
      meson
      cargo
    ];

    file.".npmrc".text = ''
      prefix=~/.local/share/nodePackages
    '';
  };

  programs = {
    obs-studio.enable = true;
    less.enable = true;
    java.enable = true;
  };

  services.network-manager-applet.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
