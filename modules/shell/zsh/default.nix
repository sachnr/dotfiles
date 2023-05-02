{
  pkgs,
  user,
  theme,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.shell.zsh;
  tmux-sessionizer = import ./tmux.nix {inherit pkgs;};
in
  with lib; {
    options.modules.shell.zsh = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "enables zsh and zsh plugins";
      };
    };

    config = mkIf cfg.enable {
      home.packages = with pkgs; [
        tmux
        tmux-sessionizer
        exa
        fzf
      ];

      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          enableAutosuggestions = true;
          autocd = true;
          dotDir = ".config/zsh";
          history = {
            expireDuplicatesFirst = true;
            path = "$HOME/.config/zsh/.zsh_history";
          };
          completionInit =
            (import ./completion.nix)
            + ''
              autoload -U +X compinit && compinit
              autoload -U +X bashcompinit && bashcompinit
            '';
          initExtraFirst = ''
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi

            if [[ -f "$HOME/.config/zsh/plugins/sudo/sudo.plugin.zsh" ]]; then
                source "$HOME/.config/zsh/plugins/sudo/sudo.plugin.zsh"
            fi

            export PATH="''${PATH}:$HOME/.npm/bin:''${HOME}/.local/share/nvim/mason/bin:''${HOME}/.cargo/bin"
            export EDITOR="nvim"
            export PYTHONPATH=$HOME/.config/pip/site-packages
          '';
          initExtra = let
            starship = "eval \"$(starship init zsh)\"";
            p10k = ''
              ZSH_THEME="powerlevel10k/powerlevel10k"
              [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
            '';
          in
            with theme.colors;
              ''
                export FZF_DEFAULT_OPTS="--layout=reverse"\
                " --color=bg+:${background3},bg:${background},spinner:${aqua},hl:${blue}"\
                " --color=fg:${brightgray},header:${blue},info:${yellow},pointer:${aqua}"\
                " --color=marker:${aqua},fg+:${foreground},prompt:${yellow},hl+:${blue}"
              ''
              + (
                if config.modules.shell.starship.enable
                then starship
                else p10k
              );
          shellAliases = {
            gg = "${pkgs.lazygit}/bin/lazygit";
            nixr = "sudo nixos-rebuild switch --flake /home/${user}/flake#desktop";
            nixc = "sudo nix-collect-garbage --delete-older-than 7d";
            ls = "${pkgs.exa}/bin/exa --icons --group-directories-first";
            la = "${pkgs.exa}/bin/exa -lah --icons --group-directories-first";
            tree = "${pkgs.exa}/bin/exa --tree --icons --group-directories-first";
            e = "${pkgs.neovim}/bin/nvim ./";
            f = "${pkgs.ranger}/bin/ranger";
            tm = "tmux-sessionizer";
          };
          plugins =
            [
              {
                name = "zsh-nix-shell";
                file = "nix-shell.plugin.zsh";
                src = pkgs.fetchFromGitHub {
                  owner = "chisui";
                  repo = "zsh-nix-shell";
                  rev = "v0.6.0";
                  sha256 = "B0mdmIqefbm5H8wSG1h41c/J4shA186OyqvivmSK42Q=";
                };
              }
            ]
            ++ (
              if config.modules.shell.starship.enable
              then []
              else [
                {
                  name = "powerlevel10k";
                  file = "powerlevel10k.zsh-theme";
                  src = pkgs.fetchFromGitHub {
                    owner = "romkatv";
                    repo = "powerlevel10k";
                    rev = "v1.17.0";
                    sha256 = "sha256-fgrwbWj6CcPoZ6GbCZ47HRUg8ZSJWOsa7aipEqYuE0Q=";
                  };
                }
              ]
            );
        };
      };

      home.file.".config/zsh/.p10k.zsh".source = ./.p10k.zsh;
      home.file.".config/zsh/plugins/sudo/sudo.plugin.zsh".source = ./sudo.plugin.zsh;
    };
  }
