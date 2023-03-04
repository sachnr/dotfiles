{theme}:
with theme.colors; {
  default = {
    settings = {
      theme = {
        theme = "modern";
        #   overrides = {
        #     idle_bg = background;
        #     idle_fg = foreground;
        #     good_bg = selection;
        #     good_fg = foreground;
        #     warning_bg = yellow;
        #     warning_fg = background;
        #     critical_bg = red;
        #     critical_fg = background;
        #     info_bg = aqua;
        #     info_fg = background;
        #     alternating_tint_bg = brightblack;
        #     alternating_tint_fg = foreground;
        #     separator_bg = background;
        #     separator_fg = gray;
        #   };
      };
      icons = {
        icons = "material-nf";
      };
    };
    blocks = [
      {
        block = "focused_window";
        format = {
          full = " $title.str(max_w:15) |";
          short = " $title.str(max_w:10) |";
        };
      }
      {
        block = "music";
        format = " $icon $volume_icon $combo $prev $play $next| ";
        seek_step_secs = 10;
      }
      {
        block = "sound";
        format = " $icon $volume ";
        headphones_indicator = true;
      }
      {
        block = "hueshift";
        hue_shifter = "redshift";
        step = 50;
        click_temp = 4200;
      }
      {
        block = "weather";
        format = " $icon $weather ($location) $temp ";
        service = {
          name = "openweathermap";
          api_key = "";
          city_id = "";
          units = "metric";
        };
      }
      {
        block = "bluetooth";
        mac = "00:18:09:92:1B:BA";
        format = " $icon ";
        disconnected_format = "";
      }
      {
        block = "net";
        format = " $icon {$signal_strength $ssid} via $device ";
      }
      {
        block = "time";
        format = "   %a, %d/%m   %I:%M %p ";
        interval = 60;
      }
      {
        block = "menu";
        text = "   ";
        items = [
          {
            display = " -&gt;  Exit   &lt;-";
            cmd = "i3-msg exit";
            confirm_msg = " Are you sure you want to exit? ";
          }
          {
            display = " -&gt;   Sleep   &lt;-";
            cmd = "systemctl suspend";
          }
          {
            display = " -&gt;  Reboot   &lt;-";
            cmd = "reboot";
            confirm_msg = " Are you sure you want to reboot? ";
          }

          {
            display = " -&gt; Power Off &lt;-";
            cmd = "poweroff";
            confirm_msg = " Are you sure you want to power off? ";
          }
        ];
      }
    ];
  };
}
