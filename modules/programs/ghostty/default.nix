{ config, lib, theme, inputs, pkgs, ... }:
let
  cfg = config.modules.programs.ghostty;
  configContent = import ./settings.nix { inherit theme lib; };
in with lib; {
  options.modules.programs.ghostty = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable ghostty";
    };
  };

  config = mkIf cfg.enable {
    programs.ghostty = {
      enable = true;
      package =
        inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.ghostty;
    };

    home.activation.copyGhosttyFiles =
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
              echo "Setting up Ghostty files..."
              mkdir -p $HOME/.config/ghostty
              
              # Force copy all files, replacing existing ones
              cp -f ${toString ./bloom.glsl} $HOME/.config/ghostty/bloom.glsl
              cp -f ${
                toString ./cursor_blaze_no_trail.glsl
              } $HOME/.config/ghostty/cursor_blaze_no_trail.glsl
              cp -f ${
                toString ./cursor_smear.glsl
              } $HOME/.config/ghostty/cursor_smear.glsl
              cp -f ${
                toString ./tab-style.css
              } $HOME/.config/ghostty/tab-style.css
              
              # Write config content directly (since settings.nix returns a string)
              cat > $HOME/.config/ghostty/config << 'EOF'
        ${configContent}
        EOF
              
              # Set proper permissions
              chmod 644 $HOME/.config/ghostty/*
              echo "Ghostty files setup complete"
      '';
  };
}
