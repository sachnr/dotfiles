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
        direnv
        go-mtpfs
        gnome.gvfs
        glow
        brightnessctl
        gimp
        gpick

        # qt
        lxqt.pcmanfm-qt
        lxqt.lxqt-menu-data
        lxqt.lxqt-archiver

        # General
        networkmanagerapplet

        # Media
        feh
        pavucontrol

        # Browsers
        ungoogled-chromium
        firefox-bin

        # Language Servers
        sumneko-lua-language-server
        nodePackages.vscode-langservers-extracted
        nil
        gopls

        # Languages
        gcc
        rustup
        go
        # gotools
        # clang
        # clang-tools
        typescript
        nodePackages.typescript-language-server
        ruby_3_2

        # Dev-tools
        git
        jq
        pkg-config
        yarn
        nodejs_18

        # debugger
        gdb
        vscode-extensions.ms-vscode.cpptools

        # Formatters
        black
        shfmt
        stylua
        # nodePackages.prettier
        nixfmt-classic
        pgformatter
        taplo

        #build
        gnumake
      ];
    };

    # Let Home Manager install and manage itself.
    programs = {
      home-manager.enable = true;
      zathura = {
        enable = true;
        options = { selection-clipboard = "clipboard"; };
      };
    };

    services = {
      network-manager-applet.enable = true;
      udiskie = {
        enable = true;
        notify = false;
      };
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    modules = {
      xorg = { awesomeConfig.enable = true; };
      wayland = {
        hyprlandConfig.enable = false;
        dunst.enable = true;
        swayConfig.enable = true;
        mako.enable = false;
        swayidle.enable = true;
        gammastep.enable = false;
        waybar.enable = false;
      };
      programs = {
        gtk-qt.enable = true;
        neovim.enable = true;
        kitty.enable = false;
        wezterm.enable = true;
        foot.enable = false;
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
        zsh = {
          enable = true;
          host = "thinkpad";
        };
        tmux.enable = true;
      };
    };
  };
}
