{theme, ...}: let
in
  with theme.colors; ''
      * {
        border: none;
        border-radius: 0;
        font-family: Material Design Icons, ${name.fontmonospace} ;
        font-weight: bold;
        font-size: 11px;
      }
      window#waybar {
        background: rgba(0, 0, 0, 0);
        color: ${xcolor15};
      }
      #workspaces {
        margin-right: 6px;
        background-color: rgba(0, 0, 0, 0);
      }
      #workspaces button {
        all: initial;
        padding: 0 0.6em;
        margin: 2px 5px;
        border-radius: 4px;
        background-color: ${xcolor0};
        color: ${xcolor7};
        box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
      }
      #workspaces button.focused {
        color: ${xcolor15};
        background-color: ${base01};
      }

      #custom-power,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #mpd,
      #tray {
        padding: 0 0.6em;
        margin: 2px 5px;
        margin-right: 8px;
        border-radius: 4px;
        background-color: ${xcolor0};
        color: ${xcolor15};
        box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
      }

      #mpd{
        padding: 0 2em;
      }

      tooltip {
        font-family: "RobotoMono Nerd Font";
        font-size : 13px;
        border-radius: 8px;
        padding: 20px;
        margin: 30px;
      }

      tooltip label {
        font-family: "RobotoMono Nerd Font Bold";
        font-size : 15px;
        padding: 20px;
      }

    #custom-power {
      font-size: 13;
      margin-right: 6px;
    }
  ''
