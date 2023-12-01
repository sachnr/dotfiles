{
  pkgs,
  lib,
  config,
  theme,
  ...
}: let
  cfg = config.modules.programs.rofi;

  roficfg = with theme; ''
     /**
     *
     * Author : Aditya Shakya (adi1090x)
     * Github : @adi1090x
     * 
     * Rofi Theme File
     * Rofi Version: 1.7.3
     **/

    /*****----- Configuration -----*****/
    configuration {
    	modi:                       "drun";
        show-icons:                 true;
        display-drun:               "";
        display-run:                "";
        display-filebrowser:        "";
        display-window:             "";
    	drun-display-format:        "{icon} {name}";
    	window-format:              "{w} · {c} · {t}";
      font:                   "${settings.fontmonospace} 11";
      icon-theme:                 "Papirus Dark";
    }

    /*****----- Global Properties -----*****/

    * {
        border-colour:               ${accent};
        handle-colour:               ${accent};
        background-colour:           ${background};
        foreground-colour:           ${foreground};
        alternate-background:        ${background};
        normal-background:           ${background};
        normal-foreground:           ${foreground};
        urgent-background:           ${red};
        urgent-foreground:           ${background};
        active-background:           ${green};
        active-foreground:           ${background};
        selected-normal-background:  ${accent};
        selected-normal-foreground:  ${background};
        selected-urgent-background:  ${red};
        selected-urgent-foreground:  ${background};
        selected-active-background:  ${green};
        selected-active-foreground:  ${background};
        alternate-normal-background: ${background};
        alternate-normal-foreground: ${foreground};
        alternate-urgent-background: ${red};
        alternate-urgent-foreground: ${background};
        alternate-active-background: ${accent};
        alternate-active-foreground: ${background};
    }

    /*****----- Main Window -----*****/
    window {
        /* properties for window widget */
        transparency:                "real";
        location:                    center;
        anchor:                      center;
        fullscreen:                  false;
        width:                       600px;
        x-offset:                    0px;
        y-offset:                    0px;

        /* properties for all widgets */
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      1px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        cursor:                      "default";
        /* Backgroud Colors */
        background-color:            @background-colour;
        /* Backgroud Image */
        //background-image:          url("/path/to/image.png", none);
        /* Simple Linear Gradient */
        //background-image:          linear-gradient(red, orange, pink, purple);
        /* Directional Linear Gradient */
        //background-image:          linear-gradient(to bottom, pink, yellow, magenta);
        /* Angle Linear Gradient */
        //background-image:          linear-gradient(45, cyan, purple, indigo);
    }

    /*****----- Main Box -----*****/
    mainbox {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     30px;
        border:                      0px solid;
        border-radius:               0px 0px 0px 0px;
        border-color:                @border-colour;
        background-color:            transparent;
        children:                    [ "inputbar", "message", "listview" ];
    }

    /*****----- Inputbar -----*****/
    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     6px;
        border:                      0px solid;
        border-radius:               6px;
        border-color:                @border-colour;
        background-color:            @alternate-background;
        text-color:                  @foreground-colour;
        children:                    [ "textbox-prompt-colon", "entry", "mode-switcher" ];
    }

    prompt {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }
    textbox-prompt-colon {
        enabled:                     true;
        padding:                     5px 0px;
        expand:                      false;
        str:                         "";
        background-color:            inherit;
        text-color:                  inherit;
    }
    entry {
        enabled:                     true;
        padding:                     5px 0px;
        background-color:            inherit;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "Search...";
        placeholder-color:           inherit;
    }
    num-filtered-rows {
        enabled:                     true;
        expand:                      false;
        background-color:            inherit;
        text-color:                  inherit;
    }
    textbox-num-sep {
        enabled:                     true;
        expand:                      false;
        str:                         "/";
        background-color:            inherit;
        text-color:                  inherit;
    }
    num-rows {
        enabled:                     true;
        expand:                      false;
        background-color:            inherit;
        text-color:                  inherit;
    }
    case-indicator {
        enabled:                     true;
        background-color:            inherit;
        text-color:                  inherit;
    }

    /*****----- Listview -----*****/
    listview {
        enabled:                     true;
        columns:                     3;
        lines:                       5;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        reverse:                     false;
        fixed-height:                true;
        fixed-columns:               true;
      
        spacing:                     5px;
        margin:                      0px;
        padding:                     4px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      "default";
    }
    scrollbar {
        handle-width:                5px ;
        handle-color:                @handle-colour;
        border-radius:               10px;
        background-color:            @alternate-background;
    }

    /*****----- Elements -----*****/
    element {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
        cursor:                      pointer;
    }
    element normal.normal {
        background-color:            var(normal-background);
        text-color:                  var(normal-foreground);
    }
    element normal.urgent {
        background-color:            var(urgent-background);
        text-color:                  var(urgent-foreground);
    }
    element normal.active {
        background-color:            var(active-background);
        text-color:                  var(active-foreground);
    }
    element selected.normal {
        background-color:            var(selected-normal-background);
        text-color:                  var(selected-normal-foreground);
    }
    element selected.urgent {
        background-color:            var(selected-urgent-background);
        text-color:                  var(selected-urgent-foreground);
    }
    element selected.active {
        background-color:            var(selected-active-background);
        text-color:                  var(selected-active-foreground);
    }
    element alternate.normal {
        background-color:            var(alternate-normal-background);
        text-color:                  var(alternate-normal-foreground);
    }
    element alternate.urgent {
        background-color:            var(alternate-urgent-background);
        text-color:                  var(alternate-urgent-foreground);
    }
    element alternate.active {
        background-color:            var(alternate-active-background);
        text-color:                  var(alternate-active-foreground);
    }
    element-icon {
        background-color:            transparent;
        text-color:                  inherit;
        size:                        24px;
        cursor:                      inherit;
    }
    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        highlight:                   inherit;
        cursor:                      inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    /*****----- Mode Switcher -----*****/
    mode-switcher{
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }
    button {
        padding:                     5px 10px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            @alternate-background;
        text-color:                  inherit;
        cursor:                      pointer;
    }
    button selected {
        background-color:            var(selected-normal-background);
        text-color:                  var(selected-normal-foreground);
    }

    /*****----- Message -----*****/
    message {
        enabled:                     true;
        margin:                      0px;
        padding:                     0px;
        border:                      0px solid;
        border-radius:               0px 0px 0px 0px;
        border-color:                @border-colour;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }
    textbox {
        padding:                     8px 10px;
        border:                      0px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            @alternate-background;
        text-color:                  @foreground-colour;
        vertical-align:              0.5;
        horizontal-align:            0.0;
        highlight:                   none;
        placeholder-color:           @foreground-colour;
        blink:                       true;
        markup:                      true;
    }
    error-message {
        padding:                     10px;
        border:                      2px solid;
        border-radius:               10px;
        border-color:                @border-colour;
        background-color:            @background-colour;
        text-color:                  @foreground-colour;
    }'';
in
  with lib; {
    options.modules.programs.rofi = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable rofi";
      };
    };

    config = mkIf cfg.enable {
      home = {
        packages = with pkgs; [
          rofi-wayland
        ];
      };
      home.file.".config/rofi/config.rasi".text = roficfg;
    };
  }
