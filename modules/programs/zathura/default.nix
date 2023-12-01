{
  config,
  lib,
  theme,
  ...
}: let
  cfg = config.modules.programs.zathura;
in
  with lib; {
    options.modules.programs.zathura = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable zathura";
      };
    };

    config = mkIf cfg.enable {
      programs.zathura = {
        enable = true;
        mappings = {
        };
        extraConfig = "set sandbox none";
        options = with theme; {
          smooth-scroll = false;
          selection-clipboard = "clipboard";
          default-bg = background;
          default-fg = foreground;
          font = "${settings.fontmonospace}";
          completion-highlight-bg = blue;
          completion-highlight-fg = black;
          completion-group-bg = black;
          completion-group-fg = brightblue;
          completion-bg = background2;
          completion-fg = foreground;
          inputbar-bg = background2;
          inputbar-fg = foreground;
          notification-bg = background2;
          notification-fg = foreground;
          notification-error-bg = red;
          notification-error-fg = black;
          notification-warning-bg = yellow;
          notification-warning-fg = black;
          statusbar-bg = background2;
          statusbar-fg = foreground;
          index-bg = background;
          index-fg = foreground;
          index-active-bg = blue;
          index-active-fg = black;
          recolor-lightcolor = background;
          recolor-darkcolor = foreground;
          render-loading-bg = background;
          render-loading-fg = foreground;
          page-padding = 0;
        };
      };
    };
  }
