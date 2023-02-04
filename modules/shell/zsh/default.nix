{
  pkgs,
  user,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.shell.zsh;
in
  with lib;
  with theme.colors; {
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
          enableSyntaxHighlighting = true;
          autocd = true;
          dotDir = ".config/zsh";
          history = {
            expireDuplicatesFirst = true;
            path = "$HOME/.config/zsh/.zsh_history";
          };
          initExtraFirst = ''
            if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
              source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
            fi

            export PATH="''${PATH}:$HOME/.local/share/nodePackages/bin:''${HOME}/.local/share/nvim/mason/bin"
            export EDITOR="nvim"
          '';
          initExtra = ''
            if [[ -f "$HOME/.config/zsh/plugins/ohmyzsh/plugins/sudo/sudo.plugin.zsh" ]]; then
              source "$HOME/.config/zsh/plugins/ohmyzsh/plugins/sudo/sudo.plugin.zsh"
            fi

            if [[ -f "$HOME/.config/zsh/plugins/ohmyzsh/lib/theme-and-appearance.zsh" ]]; then
              source "$HOME/.config/zsh/plugins/ohmyzsh/lib/theme-and-appearance.zsh"
            fi

            if [[ -f "$HOME/.config/zsh/plugins/ohmyzsh/lib/completion.zsh" ]]; then
              source "$HOME/.config/zsh/plugins/ohmyzsh/lib/completion.zsh"
            fi

            ZSH_THEME="powerlevel10k/powerlevel10k"
            [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

            zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
            zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --color=always --group-directories-first $realpath'

            export FZF_DEFAULT_OPTS='
              --ansi --layout=reverse
            '
          '';
          shellAliases = {
            gg = "${pkgs.gitui}/bin/gitui";
            nixr = "sudo nixos-rebuild switch --flake /home/${user}/flake#desktop";
            nixc = "sudo nix-collect-garbage --delete-older-than 7d";
            ls = "${pkgs.exa}/bin/exa --icons --group-directories-first";
            la = "${pkgs.exa}/bin/exa -lah --icons --group-directories-first";
            tree = "${pkgs.exa}/bin/exa --tree --icons --group-directories-first";
            e = "${pkgs.neovim}/bin/nvim ./";
            ef = "${pkgs.neovim}/bin/nvim $(${pkgs.fzf}/bin/fzf)";
            f = "${pkgs.ranger}/bin/ranger";
          };
          plugins = [
            {
              name = "powerlevel10k";
              file = "powerlevel10k.zsh-theme";
              src = pkgs.fetchFromGitHub {
                owner = "romkatv";
                repo = "powerlevel10k";
                rev = "v1.16.1";
                sha256 = "sha256-DLiKH12oqaaVChRqY0Q5oxVjziZdW/PfnRW1fCSCbjo=";
              };
            }
            {
              name = "zsh-vi-mode";
              src = pkgs.fetchFromGitHub {
                owner = "jeffreytse";
                repo = "zsh-vi-mode";
                rev = "v0.9.0";
                sha256 = "sha256-KQ7UKudrpqUwI6gMluDTVN0qKpB15PI5P1YHHCBIlpg=";
              };
            }
            {
              name = "ohmyzsh";
              file = "plugins/git/git.plugin.zsh";
              src = pkgs.fetchFromGitHub {
                owner = "ohmyzsh";
                repo = "ohmyzsh";
                rev = "a3c579bf27b34942d4c6ad64e7cfd75788b05ea3";
                sha256 = "sha256-rfKFQzECnovJLPNrEpcPPMu+C5HwfKBTZvw4WuGQY4M=";
              };
            }
          ];
        };
      };

      home.file.".config/zsh/.p10k.zsh".source = ./.p10k.zsh;
    };
  }
