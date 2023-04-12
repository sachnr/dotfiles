{
  pkgs,
  user,
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.zsh;
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

            export PATH="''${PATH}:$HOME/.local/share/nodePackages/bin:''${HOME}/.local/share/nvim/mason/bin:''${HOME}/.cargo/bin"
            export EDITOR="nvim"
          '';
          initExtra = let
            starship = "eval \"$(starship init zsh)\"";
            p10k = ''
              ZSH_THEME="powerlevel10k/powerlevel10k"
              [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
            '';
          in
            ''
              export FZF_DEFAULT_OPTS='
                --ansi --layout=reverse
              '
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
            e = "${pkgs.neovim}/bin/nvim $PWD";
            f = "${pkgs.ranger}/bin/ranger";
            fd = "cd $(cat /home/${user}/Documents/paths | fzf)";
          };
          plugins =
            [
              {
                name = "zsh-vi-mode";
                src = pkgs.fetchFromGitHub {
                  owner = "jeffreytse";
                  repo = "zsh-vi-mode";
                  rev = "v0.9.0";
                  sha256 = "sha256-KQ7UKudrpqUwI6gMluDTVN0qKpB15PI5P1YHHCBIlpg=";
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
