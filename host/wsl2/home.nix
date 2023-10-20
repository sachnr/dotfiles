{lib, ...}: let
  # returns list of all folders in path
  getDirfolders = path: (lib.attrsets.mapAttrsToList (name: _: path + ("/" + name)) (lib.attrsets.filterAttrs (name: value: value == "directory") (builtins.readDir path)));

  shell = getDirfolders ../../modules/shell;
  xorg = getDirfolders ../../modules/xorg;
  wayland = getDirfolders ../../modules/wayland;
  programs = getDirfolders ../../modules/programs;
  services = getDirfolders ../../modules/services;
in {
  imports = shell ++ xorg ++ wayland ++ programs ++ services;

  config = {
    xdg.userDirs = {
      enable = true;
      createDirectories = true;
    };

    home = {
      username = "sachnr";
      homeDirectory = "/home/sachnr";
      stateVersion = "23.05";

      packages = with pkgs; [
        # Terminal
        ranger
        lazygit
        gh-dash
        ripgrep

        # Downloader
        wget
        aria

        # Language Servers
        sumneko-lua-language-server
        # rust-analyzer
        ccls

        # Dev
        git
        gcc
        rustup
        nodePackages.npm
        nodejs
        # go

        # Formatters
        black
        shfmt
        stylua
        astyle
        nodePackages.prettier
        alejandra
      ];
    };

    modules = {
      programs = {
        neovim.enable = true;
      };
      shell = {
        zsh.enable = true;
        starship.enable = true;
      };
    };
  };
}
