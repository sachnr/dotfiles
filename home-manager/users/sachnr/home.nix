{
  inputs,
  pkgs,
  system,
  user,
  ...
}: let
  statix-git =
    pkgs.statix.overrideAttrs
    (prevAttrs: rec {
      version = "9cb88dd";

      src = pkgs.fetchFromGitHub {
        owner = "nerdypepper";
        repo = "statix";
        rev = "9cb88dd5d13f0ba36e1bd099f1a832d5bfe3127a";
        sha256 = "sha256-SEgIBRVi/EcpyCbpKLUuhcLxPexPTEoEXD/b72XXiAU=";
      };
    });
in {
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
      youtube-dl

      # General
      neovim
      networkmanagerapplet
      blueberry
      veracrypt

      # media
      feh
      pavucontrol
      steam
      handbrake

      # File Manager
      libsForQt5.dolphin-plugins
      libsForQt5.dolphin
      libsForQt5.ark

      # icons
      papirus-icon-theme

      # fonts
      roboto
      (nerdfonts.override {fonts = ["JetBrainsMono" "RobotoMono"];})

      # Browsers
      tor-browser-bundle-bin

      # Downloader
      qbittorrent
      wget
      aria

      # Language Servers
      sumneko-lua-language-server
      python39Packages.python-lsp-server
      nodePackages.bash-language-server
      nodePackages.yaml-language-server
      nodePackages.vue-language-server
      nodePackages.vscode-langservers-extracted
      nodePackages.eslint_d
      nodePackages.eslint
      efm-langserver
      statix-git
      sqls
      ccls

      # Dev
      python39Full
      git
      nodePackages.npm
      nodejs
      jq
      vimPlugins.markdown-preview-nvim

      # Formatters
      black
      shfmt
      stylua
      astyle
      nodePackages.prettier
      alejandra

      # Compiler
      gcc
      gdb
      go

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

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };
}
