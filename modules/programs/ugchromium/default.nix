{
  pkgs,
  lib,
  config,
  user,
  theme,
  ...
}: let
  cfg = config.modules.programs.ugchromium;
in
  with lib; {
    options.modules.programs.ugchromium = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable ungoogled Chromium";
      };
    };

    config = mkIf cfg.enable {
      programs.chromium = {
        enable = true;
        package = pkgs.ungoogled-chromium;
        extensions = [
          {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
          {id = "dbepggeogbaibhgnhhndojpepiihcmeb";} # vimium
          {id = "fhcgjolkccmbidfldomjliifgaodjagh";} # Cookie AutoDelete
          {id = "mjdepdfccjgcndkmemponafgioodelna";} # DF Tube
          {id = "eimadpbcbfnmbkopoojfekhnkhdbieeh";} # DarkReader
          {id = "gebbhagfogifgggkldgodflihgfeippi";} # Return YouTube Dislike
          {id = "ialbpcipalajnakfondkflpkagbkdoib";} # lovely Forks
          {id = "ajopnjidmegmdimjlfnijceegpefgped";} # BetterTTV
          {id = "ldpochfccmkkmhdbclfhpagapcfdljkj";} # Decentralized
        ];
      };
    };
  }
