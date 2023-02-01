{
  pkgs,
  config,
  lib,
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
      # fixMdPreview = mkOption {
      #   type = types.bool;
      #   default = false;
      #   description = "adds patched binary of mardown-preview-nvim";
      # };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          neovim-unwrapped
        ];
        # file.".local/share/nvim/site/pack/packer/start/markdown-preview.nvim/app/" = mkIf cfg.fixMdPreview {
        #   source = md-preview;
        #   recursive = true;
        # };
      };
    };
  }
