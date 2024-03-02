{ pkgs, config, lib, theme, ... }:
let cfg = config.modules.programs.st;
in with lib; {
  options.modules.programs.st = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable st";
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      let pkg = (pkgs.callPackage ../../../_sources/generated.nix { }).stfork;
      in with pkgs;
      [
        (st.overrideAttrs (oldAttrs: rec {
          pname = pkg.pname;
          version = pkg.version;
          src = pkg.src;
          configFile = writeText "config.def.h" (builtins.readFile ./config.h);
          postPatch = ''
            ${oldAttrs.postPatch}
             cp ${configFile} config.def.h'';
          buildInputs = with pkgs; oldAttrs.buildInputs ++ [ harfbuzz gd glib ];
        }))
      ];
  };
}
