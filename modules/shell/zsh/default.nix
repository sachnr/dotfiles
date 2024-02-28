{
  pkgs,
  user,
  theme,
  config,
  lib,
  ...
}: let
  cfg = config.modules.shell.zsh;
  getPackage = pname: pkgs: (pkgs.callPackage ../../../_sources/generated.nix {}).${pname};
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
        eza
        fzf
        bottom
      ];

      programs = {
        zsh = {
          enable = true;
          enableCompletion = true;
          enableAutosuggestions = true;
          autocd = false;
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

            export PATH="''${PATH}:$HOME/.npm/bin:''${HOME}/.local/share/nvim/mason/bin"
            export PATH="''${PATH}:$HOME/.cargo/bin"
            export PATH="''${PATH}:$HOME/go/bin"
            export EDITOR="nvim"
            export PYTHONPATH=$HOME/.config/pip/site-packages
            eval "$(direnv hook zsh)"
          '';
          initExtra = with theme.colors; ''
            export FZF_DEFAULT_OPTS="--layout=reverse"\
            " --color=bg+:${primary.background2},bg:${primary.background},spinner:${bright.red},hl:${bright.black}"\
            " --color=fg:${primary.foreground},header:${bright.black},info:${bright.cyan},pointer:${bright.red}"\
            " --color=marker:${bright.red},fg+:${primary.foreground},prompt:${bright.red},hl+:${bright.red}"

            ZSH_THEME="powerlevel10k/powerlevel10k"
            [[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
          '';
          shellAliases = {
            gg = "${pkgs.lazygit}/bin/lazygit";
            nixr = "sudo nixos-rebuild switch --flake /home/${user}/flake#desktop";
            nixc = "sudo nix-collect-garbage --delete-older-than 7d";
            ls = "${pkgs.eza}/bin/eza --icons --group-directories-first";
            la = "${pkgs.eza}/bin/eza -lah --icons --group-directories-first";
            tree = "${pkgs.eza}/bin/eza --tree --icons --group-directories-first";
            e = "${pkgs.neovim}/bin/nvim ./";
            f = "${pkgs.ranger}/bin/ranger";
            tm = "tmux-fzy";
            bk = "find ~/Documents/Books -mindepth 1 | fzf | xargs -I {} zathura '{}' --fork";
            top = "${pkgs.bottom}/bin/btm -b";
            gotest = "gotestsum -f testdox";
          };
          plugins = let
            zsh-nix-shell = getPackage "zsh-nix-shell" pkgs;
            powerlevel10k = getPackage "powerlevel10k" pkgs;
          in [
            {
              name = "zsh-nix-shell";
              file = "nix-shell.plugin.zsh";
              src = zsh-nix-shell.src;
            }
            {
              name = "powerlevel10k";
              file = "powerlevel10k.zsh-theme";
              src = powerlevel10k.src;
            }
          ];
        };
      };

      home.file.".config/zsh/.p10k.zsh".source = ./.p10k.zsh;
      home.file.".config/zsh/plugins/sudo/sudo.plugin.zsh".source = ./sudo.plugin.zsh;
    };
  }
