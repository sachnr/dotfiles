{theme, ...}: with theme; ''
      * {
        border: none;
        border-radius: 0;
        font-family: "Roboto", "Symbols Nerd Font Mono" ;
        font-weight: bold;
        font-size: 13.5px;
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
        color: ${accent};
        background-color: ${background};
      }
      #workspaces button.active {
        color: ${background};
        background-color: ${accent};
      }
      #workspaces button.persistent{
        color: ${brightblack};
      }
      #workspaces button.urgent{
        color: ${brightred};
      }

      #custom-power,
      #custom-color,
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
        font-family: "Roboto Mono";
        font-size : 12px;
        border-radius: 8px;
        padding: 10px;
        margin: 30px;
      }

      tooltip label {
        font-family: "Roboto Mono Bold";
        font-size : 13px;
        font-weight: bold;
        padding: 20px;
      }

    #custom-power {
      font-size: 13px;
      margin-right: 6px;
    }
  ''
