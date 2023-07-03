{
  pkgs,
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.shell.starship;
in
  with lib; {
    options.modules.shell.starship = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable starship prompt";
      };
    };

    config = mkIf cfg.enable {
      programs.starship = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        settings = with theme; {
          add_newline = false;
          c = {
            symbol = "[ ](bold blue)";
            style = "bright-black";
            format = "\\[[$symbol($version(-$name))]($style)\\] ";
          };
          git_branch = {
            symbol = "[ ](bold ${gray})";
            style = "bold ${gray}";
            format = "on [$symbol$branch]($style) ";
          };
          git_status = {
            conflicted = "[=](bold bright-red)";
            ahead = "[⇡\${count}](bold bright-green)";
            behind = "[⇣\${count}](bold bright red)";
            diverged = "⇕[⇡\${ahead_count}](bold bright-green)[⇣\${behind_count}](bold bright-red)";
            untracked = "[?\${count}](bold bright-white)";
            stashed = "[+](bold bright-cyan)";
            modified = "[!\${count}](bold bright-yellow)";
            staged = "[+\${count}](bold bright-green)";
            renamed = "[»\${count}](bold bright-purple)";
            deleted = "[✘\${count}](bold bright-red)";
            format = "([$all_status$ahead_behind]($style)) ";
          };
          git_commit = {
            style = "bold green";
            format = "[\\($hash$tag\\)]($style) ";
          };
          git_state = {
            style = "bold yellow";
            format = "\\([$state( $progress_current/$progress_total)]($style)\\) ";
          };
          java = {
            symbol = "[ ](bold blue) ";
            style = "bright-black";
            format = "\\[[$symbol($version)]($style)\\] ";
          };
          lua = {
            symbol = "[󰢱 ](bold ${aqua}) ";
            style = "bright-black";
          };
          nodejs = {
            symbol = "[ ](bold green)";
            style = "bright-black";
            format = "\\[[$symbol($version)]($style)\\] ";
          };
          nix_shell = {
            symbol = "[ ](bright-cyan)";
            style = "bright-black";
            format = "\\[[$symbol$state-$name]($style)\\] ";
            pure_msg = "pure";
            impure_msg = "impure";
          };
          shell = {
            format = "\\[[$indicator]\\]($style) ";
          };
          directory = {
            truncation_length = 5;
            style = "bold ${accent}";
            format = "[$path]($style)[$lock_symbol]($lock_style) ";
          };
          line_break = {
            disabled = true;
          };
          cmd_duration = {
            format = "in [$duration]($style) ";
            style = "bold ${green}";
          };
          os = {
            disabled = false;
            symbols = {
              Windows = "[ ](bold blue)";
              Android = "[ ](bold green)";
              Linux = "[ ](bold white)";
              NixOS = "[ ](bold bright-blue)";
            };
            style = "bold bright-cyan";
            format = "[$symbol]($style) ";
          };
          rust = {
            symbol = "[ ](bold bright-red)";
            style = "bright-black";
            format = "\\[[$symbol($version)]($style)\\] ";
          };
          docker_context = {
            symbol = "🐳";
            style = "bright-black";
            format = "\\[[$symbol$context\\]]($style) ";
          };
          format = lib.concatStrings [
            "$os"
            "$all"
          ];
          scan_timeout = 10;
          character = {
            success_symbol = "[➜](bold bright-green) ";
            error_symbol = "[➜](bold bright-red) ";
          };
        };
      };
    };
  }
