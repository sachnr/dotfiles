{
  pkgs,
  theme,
  ...
}: {
  mainBar = {
    layer = "top";
    position = "top";
    height = 32;
    mode = "dock";
    exclusive = true;
    passthrough = false;
    fixed-center = true;
    gtk-layer-shell = true;
    output = [
      "HDMI-A-1"
    ];
    modules-left = [
      # "sway/workspaces"
      # "sway/mode"
      # "sway/scratchpad"
      # "sway/window"
      "wlr/workspaces"
    ];
    modules-center = [
      "mpd"
    ];
    modules-right = [
      "tray"
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
        "1" = [];
        "2" = [];
        "3" = [];
        "4" = [];
        "5" = [];
        "6" = [];
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

    "wlr/workspaces" = {
      format = "<span font_family='Symbols Nerd Font Mono' size='medium'>{icon}</span>";
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
      "format-icons" = ["" ""];
      "tooltip" = true;
      "tooltip-format" = "{app}: {title}";
    };

    "sway/window" = {
      max-length = 20;
    };

    "custom/power" = with theme; {
      tooltip = false;
      on-click = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
      format = "<span font_family=\"Symbols Nerd Font Mono\" size=\"medium\" color=\"${theme.accent}\">   </span>";
    };

    "sway/mode" = {
      "format" = "  {} ";
      "max-length" = 50;
    };

    pulseaudio = {
      tooltip = false;
      format = " <span color=\"${theme.accent}\" font_family='Symbols Nerd Font Mono' size='medium'>{icon}</span> {volume}% ";
      format-muted = " <span color=\"${theme.red}\" font_family='Symbols Nerd Font Mono' size='medium' rise='-4000'>󰖁 </span> muted ";
      format-icons = {
        default = [" 󰕿 " " 󰖀 " " 󰕾 "];
        headphone = " ";
        headset = " ";
      };
      tooltip-format = "{desc}, {volume}%";
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
      on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      on-click-right = pkgs.writeShellScript "wpctl_toggle_sink" ''
        isheadphone() {
          status=$(pactl list sinks | rg -e analog-output- | awk '/Active Port:/{print $3}')
          if [[ $status = 'analog-output-headphones' ]]; then
            echo $?
          else
            echo $?
          fi
        }
        togglesink() {
          status="$(isheadphone)"
          if [[ "$status" = "0" ]]; then
            pactl set-sink-port 0 analog-output-lineout
          else
            pactl set-sink-port 0 analog-output-headphones
          fi
        }
        togglesink
      '';
    };

    tray = {
      icon-size = 14;
      spacing = 10;
    };

    clock = {
      tooltip = false;
      format = "<span font_family=\"Symbols Nerd Font Mono\" size=\"medium\" color=\"${theme.accent}\">󱑎</span>  {:%H:%M} ";
    };

    "clock#date" = {
      format = "<span font_family=\"Symbols Nerd Font Mono\" size=\"medium\" color=\"${theme.accent}\">󰃶</span>  {:%a %d %b} ";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
    };

    "mpd" = {
      "format" = " <span font_family=\"Symbols Nerd Font Mono\" size=\"medium\" color=\"${theme.accent}\">{stateIcon}</span>   {artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})   <span font_family=\"Symbols Nerd Font Mono\" size=\"medium\" color=\"${theme.accent}\"> </span>";
      "format-disconnected" = " Disconnected <span font_family=\"Symbols Nerd Font Mono\" size=\"medium\" color=\"${theme.accent}\"> </span>";
      "format-stopped" = " Stopped <span font_family=\"Symbols Nerd Font Mono\" size=\"medium\" color=\"${theme.accent}\"> </span>";
      "interval" = 2;
      "port" = 6600;
      "consume-icons" = {
        "on" = " ";
      };
      "random-icons" = {
        "off" = " ";
        "on" = " ";
      };
      "repeat-icons" = {
        "on" = " ";
      };
      "single-icons" = {
        "on" = "1 ";
      };
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
  };
}
