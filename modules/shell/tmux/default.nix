{ pkgs, config, lib, inputs, theme, ... }:
let
  cfg = config.modules.shell.tmux;
  tmux-conf = pkgs.callPackage ../../../configs/tmux { inherit lib theme; };
in with lib; {
  options.modules.shell.tmux = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "multiplexer";
    };
  };

  config = mkIf cfg.enable {
    programs.tmux = { enable = true; };
    home.file.".config/tmux/plugins/tpm".source = inputs.tmux-tpm;
    home.file.".config/tmux" = {
      source = tmux-conf;
      recursive = true;
    };
  };
}
