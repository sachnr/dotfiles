{pkgs, ...}: let
in {
  mainBar = {
    layer = "top";
    position = "top";
    height = 24;
    mode = "dock";
    exclusive = true;
    passthrough = false;
    fixed-center = true;
    gtk-layer-shell = true;
    output = [
      "HDMI-A-1"
    ];
    modules-left = [
      "sway/workspaces"
      "sway/mode"
      "sway/window"
    ];
    modules-center = ["mpd"];
    modules-right = [
      "tray"
      "pulseaudio"
      "clock#date"
      "clock"
      "custom/power"
    ];

    "sway/workspaces" = {
      disable-scroll = true;
      all-outputs = true;
    };

    "sway/window" = {
      icon = true;
      icon-size = 16;
      max-length = 24;
    };

    "custom/power" = {
      tooltip = false;
      on-click = "eww open --toggle dashboard";
      format = "󰤆";
    };

    "sway/mode" = {
      "format" = " {}";
      "max-length" = 50;
    };

    pulseaudio = {
      tooltip = false;
      format = " {icon} {volume}% ";
      format-muted = " 󰖁 muted ";
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
      format = " 󱑎 {:%H:%M} ";
    };

    "clock#date" = {
      format = " 󰃶 {:%a %d %b} ";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
    };

    "mpd" = {
      "format" = " {stateIcon}   {artist} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S})    ";
      "format-disconnected" = " Disconnected  ";
      "format-stopped" = " Stopped  ";
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
      "on-click" = "eww open --toggle music";
      "on-scroll-up" = "mpc next";
      "on-scroll-down" = "mpc prev";
      "tooltip-format" = "MPD (connected)";
      "tooltip-format-disconnected" = "MPD (disconnected)";
    };
  };
}
