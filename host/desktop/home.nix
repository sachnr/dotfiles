# Home manager setting
{
  lib,
  user,
  pkgs,
  ...
}: let
  get_dirs = path: (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name)) (lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path)));

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
      stateVersion = "23.05";

      file."/home/${user}/links/cpp_debug".source = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";

      packages = with pkgs; [
        # Terminal
        ranger
        less
        neofetch
        lazygit
        ripgrep
        yt-dlp
        gh-dash
        direnv
        go-mtpfs
        glow

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
        telegram-desktop

        # Game
        # blender
        # steam
        lutris
        wine
        winetricks
        # ldtk
        krita
        aseprite-git
        # yuzuPackages.mainline

        # Browsers
        # tor-browser-bundle-bin
        brave
        microsoft-edge

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
        # yarn
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
        alejandra
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

    services = {
      network-manager-applet.enable = true;
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    modules = {
      xorg = {
        awesomeConfig.enable = true;
      };
      wayland = {
        hyprlandConfig.enable = true;
        mako.enable = true;
        swayidle.enable = true;
        gammastep.enable = false;
        waybar.enable = true;
      };
      programs = {
        gtk-qt.enable = true;
        neovim.enable = true;
        firefox.enable = true;
        kitty.enable = true;
        wezterm.enable = false;
        foot.enable = true;
        rofi.enable = true;
        qutebrowser.enable = true;
        alacritty.enable = true;
        ugchromium.enable = false;
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
