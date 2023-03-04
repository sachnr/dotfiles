{theme, ...}: let
in
  with theme.colors; ''
      * {
        border: none;
        border-radius: 0;
        font-family: Material Design Icons, ${name.fontmonospace} ;
        font-weight: bold;
        font-size: 12px;
      }
      window#waybar {
        background: ${black};
        color: ${foreground};
        box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
      }
      #workspaces {
        margin-right: 6px;
        background-color: ${background};
        margin: 4px 6px;
        border-radius: 4px;
        box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
      }
      #workspaces button {
        all: initial;
        padding: 0.0em 0.8em;
        border-radius: 4px;
        background-color: ${background};
        color: ${foreground};
      }
      #workspaces button.focused {
        color: ${black};
        background-color: ${blue};
      }
      #workspaces button.persistent{
        color: ${brightblack};
      }
      #workspaces button.urgent{
        color: ${brightred};
      }

      #custom-power,
      #battery,
      #backlight,
      #pulseaudio,
      #network,
      #clock,
      #mode,
      #mpd,
      #scratchpad,
      #scratchpad.empty,
      #tray {
        padding: 0.0em 0.6em;
        margin: 4px 6px;
        margin-right: 8px;
        border-radius: 4px;
        background-color: ${background};
        color: ${foreground};
        box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
      }

      #window{
        color: ${gray};
      }

      #scratchpad.empty{
        color: ${gray};
      }

      #mpd{
        padding: 0 2em;
        margin: 4px 6px;
      }

      tooltip {
        font-family: "RobotoMono Nerd Font";
        font-size : 12px;
        border-radius: 8px;
        padding: 10px;
        margin: 30px;
      }

      tooltip label {
        font-family: "RobotoMono Nerd Font Bold";
        font-size : 13px;
        font-weight: bold;
        padding: 20px;
      }

    #custom-power {
      font-size: 13px;
      margin-right: 6px;
    }
  ''
