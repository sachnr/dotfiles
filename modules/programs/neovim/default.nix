{
  pkgs,
  config,
  lib,
  inputs,
  ...
}: let
  cfg = config.modules.programs.neovim;
in
  with lib; {
    options.modules.programs.neovim = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable neovim";
      };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          # neovim-unwrapped
          neovim
          tree-sitter
        ];
      };
    };
  }
