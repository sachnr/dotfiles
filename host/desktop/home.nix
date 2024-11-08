# Home manager setting
{ lib, user, pkgs, ... }:
let
  get_dirs = path:
    (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name))
      (lib.attrsets.filterAttrs (name: value: value == "directory")
        (builtins.readDir path)));

  shell = get_dirs ../../modules/shell;
  xorg = get_dirs ../../modules/xorg;
  wayland = get_dirs ../../modules/wayland;
  programs = get_dirs ../../modules/programs;
  services = get_dirs ../../modules/services;
in {
  imports = xorg ++ wayland ++ programs ++ services ++ shell;

  config = {
    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "24.05";

      file."/home/${user}/links/cpp_debug".source =
        "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";

      packages = with pkgs; [
        # compression
        p7zip
        unrar
        unzip
        zip

        # Tools
        ranger
        less
        neofetch
        lazygit
        ripgrep
        yt-dlp
        gh-dash
        direnv
        go-mtpfs
        gnome.gvfs
        glow
        ffmpeg
        nvfetcher

        # qt
        lxqt.pcmanfm-qt
        lxqt.lxqt-menu-data
        lxqt.lxqt-archiver
        zathura

        # General
        networkmanagerapplet

        # Media
        feh
        pavucontrol

        # Game
        # blender
        snixembed
        wine
        gamescope
        winetricks
        krita
        # aseprite-git

        # Browsers
        # tor-browser-bundle-bin
        brave
        ungoogled-chromium
        firefox-bin

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
        gopls
        # sqls
        # ccls
        nodePackages_latest.eslint
        zls

        # Dev
        rustup
        zig
        # python39
        # python39Packages.pip
        # jdk
        git
        nodePackages.pnpm
        yarn
        nodejs
        # deno
        jq
        # gcc
        clang
        clang-tools
        pkg-config
        go
        gotools

        # debugger
        gdb
        # lldb_15
        # delve
        # vscode-extensions.vadimcn.vscode-lldb.adapter
        vscode-extensions.ms-vscode.cpptools

        # Formatters
        black
        shfmt
        stylua
        # astyle
        nodePackages.prettier
        nixfmt-classic
        pgformatter
        taplo

        # Build tools
        # maven
        # cmake
        # gnumake
      ];
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    services = { network-manager-applet.enable = true; };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    modules = {
      xorg = { awesomeConfig.enable = true; };
      wayland = {
        hyprland.enable = true;
        dunst.enable = true;
        swayConfig.enable = false;
        mako.enable = false;
        gammastep.enable = false;
        waybar.enable = true;
      };
      programs = {
        gtk-qt.enable = true;
        neovim.enable = true;
        kitty.enable = true;
        wezterm.enable = false;
        foot.enable = true;
        rofi.enable = true;
        qutebrowser.enable = true;
        alacritty.enable = true;
        st.enable = false;
      };
      services = {
        picom.enable = true;
        mpd.enable = true;
        eww.enable = false;
        polkit.enable = true;
        gnupg.enable = true;
      };
      shell = {
        zsh.enable = true;
        tmux.enable = true;
      };
    };
  };
}
