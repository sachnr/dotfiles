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
    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
    };

    home = {
      username = user;
      homeDirectory = "/home/${user}";
      stateVersion = "25.11";

      file."/home/${user}/links/cpp_debug".source =
        "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";

      packages = with pkgs; [
        # compression
        p7zip
        unrar
        # rar
        unzip
        zip

        # Tools
        ranger
        less
        neofetch
        ffmpeg
        lazygit
        ripgrep
        direnv
        gnome.gvfs
        go-mtpfs
        pcmanfm-qt
        lxqt.lxqt-menu-data
        lxqt.lxqt-archiver
        glow
        brightnessctl
        gpick
        ghostty
        cloudflared
        gimp

        # General
        networkmanagerapplet

        # Media
        feh
        # pwvucontrol
        lxqt.pavucontrol-qt
        postman
        flameshot

        # Browsers
        brave

        # Language Servers
        sumneko-lua-language-server
        nodePackages.vscode-langservers-extracted
        nil
        gopls

        # compilers
        rustup
        go
        clang
        clang-tools
        gitlab-ci-ls

        # Dev-tools
        git
        jq
        pkg-config
        openssl
        yarn
        nodejs

        # debugger
        gdb

        # Formatters
        black
        shfmt
        stylua
        nixfmt-classic
        pgformatter
        taplo
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
        notify = true;
      };
    };

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    modules = {
      xorg = { awesomeConfig.enable = true; };
      wayland = {
        hyprland.enable = true;
        dunst.enable = true;
        sway.enable = false;
        mako.enable = false;
        gammastep.enable = false;
        waybar.enable = true;
      };
      programs = {
        gtk-qt.enable = true;
        neovim.enable = true;
        kitty.enable = false;
        wezterm.enable = false;
        foot.enable = false;
        rofi.enable = true;
        qutebrowser.enable = true;
        alacritty.enable = true;
        st.enable = false;
      };
      services = {
        picom.enable = false;
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
