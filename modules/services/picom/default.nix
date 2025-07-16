{ pkgs, config, lib, ... }:
let cfg = config.modules.services.picom;
in with lib; {
  options.modules.services.picom = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable picom";
    };
  };

  config = mkIf cfg.enable {
    services.picom = {
      enable = true;
      package = pkgs.picom;
      backend = "glx";
      settings = {
        corner-radius = 8;
        blur-size = 3;
        blur-method = "dual_kawase";
        deviation = 0.84089642;
        blur-background = true;
        blur-background-frame = false;
        blur-strength = 5;
        blur-background-exclude = [
          "window_type = 'dock'"
          "window_type = 'desktop'"
          "_GTK_FRAME_EXTENTS@:c"
          "window_type = 'menu'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'tooltip'"
        ];
        wintypes = {
          dropdown_menu = { shadow = false; };
          popup_menu = { shadow = false; };
          utility = { shadow = false; };
        };
        shadow = true;
        shadow-opacity = 0.7;
        shadow-exclude = [
          "name = 'cpt_frame_xcb_window'"
          "class_g ?= 'zoom'"
          "name = 'rect-overlay'"
          "window_type = 'menu'"
          "window_type = 'dropdown_menu'"
          "window_type = 'popup_menu'"
          "window_type = 'tooltip'"
          "_GTK_FRAME_EXTENTS@:c"
        ];
        vsync = true;
        detect-rounded-corners = true;
        detect-client-opacity = true;
        unredir-if-possible = false;
      };
    };
  };
}
