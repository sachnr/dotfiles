{theme, ...}:
with theme.colors; ''
    * {
      border: none;
      font-family: "Roboto", "Symbols Nerd Font Mono" ;
      font-weight: bold;
      font-size: 12px;
    }
    window#waybar {
      background: ${normal.black};
      color: ${primary.foreground};
      box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
    }
    #workspaces {
      background-color: ${primary.background};
      margin: 4px 6px;
      border-radius: 4px;
      box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
    }
    #workspaces button {
      all: initial;
      padding: 0em 0.4em;
      border-radius: 4px;
      background-color: ${primary.background};
      color: ${primary.foreground};
    }
    #workspaces button.focused {
      color: ${primary.accent};
      background-color: ${primary.background};
    }
    #workspaces button.active {
      color: ${primary.background};
      background-color: ${primary.accent};
    }
    #workspaces button.persistent{
      color: ${bright.black};
    }
    #workspaces button.urgent{
      color: ${bright.red};
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
      padding: 0.0em 0.4em;
      margin: 4px;
      border-radius: 4px;
      border-radius: 4px;
      background-color: ${primary.background};
      color: ${primary.foreground};
      box-shadow: 5px 4px 3px 0px rgba(1, 2, 3, 0.6);
    }

    #window{
      color: ${normal.gray};
    }

    #scratchpad.empty{
      color: ${normal.gray};
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
    font-size: 12px;
  }
''
