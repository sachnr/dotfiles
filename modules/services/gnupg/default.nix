{ pkgs, user, config, lib, ... }:
let cfg = config.modules.services.gnupg;
in with lib; {
  options.modules.services.gnupg = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enables gnupg private key agent";
    };
  };

  config = mkIf (cfg.enable) {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
    };
  };
}
