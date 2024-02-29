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

      # file."/home/${user}/links/cpp_debug".source = "${pkgs.vscode-extensions.ms-vscode.cpptools}/share/vscode/extensions/ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7";

      packages = with pkgs; [
        # Terminal
        ranger
        less
        neofetch
        lazygit
        ripgrep
        gh-dash
        direnv
        glow
        p7zip
        unrar
        unzip
        zip

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
        nodePackages.npm
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
      ];
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    modules = {
      programs = {
        neovim.enable = true;
      };
      services = {
        gnupg.enable = true;
      };
      shell = {
        zsh.enable = true;
        tmux.enable = true;
      };
    };
  };
}
