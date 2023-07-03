{pkgs, ...}: {
  services.network-manager-applet.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
  };

  home = {
    username = "sachnr";
    homeDirectory = "/home/sachnr";
    stateVersion = "23.05";

    packages = let
      veracrypt-patched = pkgs.veracrypt.overrideAttrs (prev: {
        patches = prev.patches or [] ++ [../../patches/veracrypt.patch];
      });
    in
      with pkgs; [
        # Terminal
        ranger
        less
        neofetch
        lazygit
        ripgrep
        yt-dlp
        gh-dash
        lxqt.pcmanfm-qt
        libsForQt5.ark
        direnv

        # General
        networkmanagerapplet
        # veracrypt-patched

        # media/game
        feh
        pavucontrol
        easyeffects
        steam

        # Browsers
        # tor-browser-bundle-bin

        # Downloader
        qbittorrent
        wget
        aria

        # Language Servers
        sumneko-lua-language-server
        # python39Packages.python-lsp-server
        # nodePackages.bash-language-server
        # nodePackages.yaml-language-server
        # nodePackages.vue-language-server
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
        nil
        # sqls
        ccls

        # Dev
        rustup
        python39
        python39Packages.pip
        # jdk
        git
        nodePackages.npm
        yarn
        nodejs
        deno
        jq
        gcc
        pkg-config
        # go

        # for luasnip
        luajitPackages.jsregexp

        # debugger
        gdb
        lldb_15

        # Formatters
        black
        shfmt
        stylua
        astyle
        nodePackages.prettier
        alejandra

        # Build tools
        # maven
        cmake
      ];
  };
}
