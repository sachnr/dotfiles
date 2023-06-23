{
  pkgs,
  ...
}: {
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
      less
      neofetch
      lazygit
      gh-dash
      ripgrep

      # Downloader
      wget
      aria

      # Language Servers
      sumneko-lua-language-server
      # rust-analyzer
      rnix-lsp
      ccls

      # Dev
      git
      deno
      gcc
      rustup
      nodePackages.npm
      yarn
      nodejs
      deno
      jq
      # go

      # debugger
      # gdb

      # Formatters
      black
      shfmt
      stylua
      astyle
      nodePackages.prettier
      alejandra

      # Build tools
      # maven
      # cmake
    ];
  };
}
