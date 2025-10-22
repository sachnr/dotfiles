{ theme, ... }: {
  mainBar = {
    layer = "top";
    position = "bottom";
    height = 26;
    mode = "dock";
    exclusive = true;
    passthrough = false;
    fixed-center = true;
    gtk-layer-shell = true;
    output = [ "eDP-1" "DP-2" ];
    modules-left = [
      # "sway/workspaces"
      # "sway/mode"
      # "sway/scratchpad"
      # "sway/window"
      # "wlr/workspaces"
      "hyprland/workspaces"
    ];
    modules-center = [ "mpd" ];
    modules-right = [
      "tray"
      "battery"
      "backlight"
      "network"
      "memory"
      "pulseaudio"
      "clock#date"
      "clock"
    ];

    "hyprland/window" = {
      max-length = 200;
      separate-outputs = true;
    };

    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
      format = "{icon}";
      persistent_workspaces = {
        "1" = [ ];
        "2" = [ ];
        "3" = [ ];
        "4" = [ ];
        "5" = [ ];
        "6" = [ ];
      };
      format-icons = {
        "1" = " ";
        "2" = " ";
        "3" = " ";
        "4" = "󰉋 ";
        "5" = "󰵅 ";
        "6" = "󰊠 ";
        "7" = " ";
        "8" = " ";
        "9" = " ";
      };
    };

    "hyprland/workspaces" = {
      "all-outputs" = true;
      format = "<span size='medium'>{icon}</span>";
      active-only = false;
      format-icons = {
        "1" = " ";
        "2" = " ";
        "3" = " ";
        "4" = "󰉋 ";
        "5" = "󰵅 ";
        "6" = "󰊠 ";
        "7" = " ";
        "8" = " ";
        "9" = " ";
        "urgent" = " ";
        "focused" = "";
        "default" = "";
      };
    };

    "wlr/workspaces" = {
      format = "<span size='medium'>{icon}</span>";
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      all-outputs = true;
      onclick = "activate";
      sort-by-number = true;
      format-icons = {
        "1" = " ";
        "2" = " ";
        "3" = " ";
        "4" = "󰉋 ";
        "5" = "󰵅 ";
        "6" = "󰊠 ";
        "7" = " ";
        "8" = " ";
        "9" = " ";
        "urgent" = " ";
        "focused" = "";
        "default" = "";
      };
    };

    "sway/scratchpad" = {
      "format" = "{icon} {count}";
      "show-empty" = true;
      "format-icons" = [ "" "" ];
      "tooltip" = true;
      "tooltip-format" = "{app}: {title}";
    };

    "sway/window" = { max-length = 20; };

    "custom/power" = with theme.colors; {
      tooltip = false;
      on-click =
        "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
      format = ''<span size="medium" color="${primary.accent}">   </span>'';
    };

    "custom/color" = with theme.colors; {
      tooltip = false;
      onclick = "exec wl-color-picker";
      format = ''<span size="medium" color="${primary.accent}"> 󰉦  </span>'';
    };

    "sway/mode" = {
      "format" = "  {} ";
      "max-length" = 50;
    };

    pulseaudio = with theme.colors; {
      tooltip = true;
      format =
        " <span color=\"${primary.accent}\" size='medium'>{icon}</span> {volume}% ";
      format-muted =
        " <span color=\"${normal.red}\" size='medium' rise='-4000'>󰖁 </span> muted ";
      format-icons = {
        default = [ " 󰕿 " " 󰖀 " " 󰕾 " ];
        headphone = " ";
        headset = " ";
      };
      tooltip-format = "{desc}, {volume}%";
      on-click = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
      on-scroll-up = "pactl set-sink-volume @DEFAULT_SINK@ +5%";
      on-scroll-down = "pactl set-sink-volume @DEFAULT_SINK@ -5%";
      on-click-right = "pavucontrol";
    };

    tray = {
      icon-size = 14;
      spacing = 10;
    };

    clock = with theme.colors; {
      tooltip = false;
      format =
        ''<span size="medium" color="${primary.accent}">󱑎</span>  {:%H:%M} '';
    };

    "clock#date" = with theme.colors; {
      format = ''
        <span size="medium" color="${primary.accent}">󰃶</span>  {:%a %d %b} '';
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
    };

    "mpd" = with theme.colors; {
      "format" =
        " <span size=\"medium\" color=\"${primary.accent}\">{stateIcon}</span>   {artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})   <span size=\"medium\" color=\"${primary.accent}\"> </span>";
      "format-disconnected" =
        " Disconnected <span size=\"medium\" color=\"${primary.accent}\"> </span>";
      "format-stopped" =
        " Stopped <span size=\"medium\" color=\"${primary.accent}\"> </span>";
      "interval" = 2;
      "port" = 6600;
      "consume-icons" = { "on" = " "; };
      "random-icons" = {
        "off" = " ";
        "on" = " ";
      };
      "repeat-icons" = { "on" = " "; };
      "single-icons" = { "on" = "1 "; };
      "state-icons" = {
        "paused" = "";
        "playing" = "";
      };
      "on-scroll-up" = "mpc next";
      "on-scroll-down" = "mpc prev";
      "on-click" = "mpc toggle";
      "tooltip-format" = "MPD (connected)";
      "tooltip-format-disconnected" = "MPD (disconnected)";
    };

    "battery" = with theme.colors; {
      "bat" = "BAT0";
      "interval" = 60;
      "states" = {
        "warning" = 30;
        "critical" = 15;
      };
      "format" =
        "<span size='medium' color='${primary.accent}'>{icon}</span>  {capacity}%";
      "format-icons" = [ "" "" "" "" "" ];
      "max-length" = 25;
    };

    "backlight" = with theme.colors; {
      "device" = "intel_backlight";
      "format" =
        "<span size='medium' color='${primary.accent}'>{icon}</span>  {percent}%";
      "format-icons" = [ "" "" ];
      "on-scroll-up" = "brightnessctl set +10";
      "on-scroll-down" = "brightnessctl set 10-";
    };

    "memory" = with theme.colors; {
      "interval" = 30;
      "format" = "<span size='medium' color='${primary.accent}'></span>  {}%";
      "max-length" = 10;
    };

    "network" = with theme.colors; {
      "interface" = "wlp2s0";
      "format" = "{ifname}";
      "format-wifi" =
        "<span size='medium' color='${primary.accent}'></span>  {essid} ({signalStrength}%)";
      "format-ethernet" =
        "<span size='medium' color='${primary.accent}'>󰊗</span>  {ipaddr}/{cidr}";
      "format-disconnected" = "";
      "tooltip-format" =
        "<span size='medium' color='${primary.accent}'>󰊗</span>  {ifname} via {gwaddr}";
      "tooltip-format-wifi" =
        "<span size='medium' color='${primary.accent}'></span>  {essid} ({signalStrength}%)";
      "tooltip-format-ethernet" =
        "<span size='medium' color='${primary.accent}'></span>  {ifname}";
      "tooltip-format-disconnected" = "Disconnected";
      "max-length" = 50;
    };

  };
}
