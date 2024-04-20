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
      stateVersion = "23.05";

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
        gh-dash
        direnv
        go-mtpfs
        gnome.gvfs
        glow
        cbatticon
        pasystray
        brightnessctl

        # qt
        lxqt.pcmanfm-qt
        lxqt.lxqt-menu-data
        lxqt.lxqt-archiver

        # General
        networkmanagerapplet

        # Media
        feh
        pavucontrol

        brave

        # Language Servers
        sumneko-lua-language-server
        # nodePackages.bash-language-server
        nodePackages.vscode-langservers-extracted
        nil
        gopls
        # zls

        # Dev
        rustup
        # zig
        git
        jq
        gcc
        # clang
        # clang-tools
        pkg-config
        go
        # gotools
        yarn
        nodejs_18
        typescript
        nodePackages.typescript-language-server
        ruby_3_2

        # debugger
        gdb
        vscode-extensions.ms-vscode.cpptools

        # stc
        # nodePackages_latest.pyright

        # Formatters
        black
        shfmt
        stylua
        # nodePackages.prettier
        nixfmt
        pgformatter
        taplo

        #build
        gnumake
      ];
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
    programs.zathura = {
      enable = true;
      options = { selection-clipboard = "clipboard"; };
    };

    services = { network-manager-applet.enable = true; };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    modules = {
      xorg = { awesomeConfig.enable = true; };
      # wayland = {
      #   hyprlandConfig.enable = true;
      #   mako.enable = true;
      #   swayidle.enable = true;
      #   gammastep.enable = false;
      #   waybar.enable = true;
      # };
      programs = {
        gtk-qt.enable = true;
        neovim.enable = true;
        firefox.enable = true;
        kitty.enable = true;
        wezterm.enable = false;
        foot.enable = true;
        rofi.enable = true;
        qutebrowser.enable = false;
        alacritty.enable = false;
        ugchromium.enable = false;
        st.enable = false;
      };
      services = {
        picom.enable = true;
        mpd.enable = false;
        eww.enable = false;
        polkit.enable = true;
        gnupg.enable = true;
      };
      shell = {
        zsh = {
          enable = true;
          host = "lenovo";
        };
        tmux.enable = true;
      };
    };
  };
}
