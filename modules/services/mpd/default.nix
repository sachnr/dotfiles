{ pkgs, user, config, lib, ... }:
let cfg = config.modules.services.mpd;
in with lib; {
  options.modules.services.mpd = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enables mpd and ncmpcpp";
    };
  };

  config = mkIf cfg.enable {
    home = { packages = with pkgs; [ mpv mpc-cli ]; };

    services = {
      mpd = {
        enable = true;
        playlistDirectory = "/home/${user}/.config/mpd/playlist";
        dbFile = "/home/${user}/.config/mpd/mpd.db";
        dataDir = "/home/${user}/.config/mpd";
        musicDirectory = "/home/${user}/Music";
        network = {
          listenAddress = "localhost";
          port = 6600;
        };
        extraConfig = ''
          user              "${user}"
          restore_paused    "yes"
          audio_output {
              type          "pulse"
              name          "My MPD PulseAudio Output"
          }
          audio_output {
              type          "fifo"
              name          "Visualizer"
              path          "/tmp/mpd.fifo"
              format        "44100:16:2"
          }
        '';
      };

      mpdris2.enable = true;

      # mopidy = {
      #   enable = true;
      #   extensionPackages = with pkgs; [ mopidy-mpd mopidy-youtube ];
      #   settings = {
      #     mpd = {
      #       enabled = true;
      #       hostname = "~/.config/mpd/socket";
      #       port = 6600;
      #     };
      #     youtube = {
      #       enabled = true;
      #       allow_cache = true;
      #       playlist_max_videos = 1000;
      #     };
      #   };
      # };
    };

    programs = {
      ncmpcpp = {
        enable = true;
        mpdMusicDir = "/home/${user}/Music";
        package = pkgs.ncmpcpp.override { visualizerSupport = true; };
        bindings = [
          {
            key = "j";
            command = "scroll_down";
          }
          {
            key = "k";
            command = "scroll_up";
          }
          {
            key = "J";
            command = [ "select_item" "scroll_down" ];
          }
          {
            key = "K";
            command = [ "select_item" "scroll_up" ];
          }
        ];
        settings = {
          # MPD
          # ---
          mpd_host = "localhost";
          mpd_port = 6600;
          mpd_crossfade_time = "2";

          # VISUALIZER
          # ---
          visualizer_data_source = "/tmp/mpd.fifo";
          visualizer_output_name = "Visualizer";
          visualizer_in_stereo = "no";
          visualizer_fps = "60";
          visualizer_type = "ellipse";
          visualizer_look = ".▐";
          visualizer_color = "199,200,201,202,166,130,94,58,22";
          visualizer_spectrum_smooth_look = "yes";

          # GENERAL
          # ---
          lyrics_directory = "~/.config/mpd/lyrics";
          connected_message_on_startup = "yes";
          cyclic_scrolling = "yes";
          mouse_support = "yes";
          mouse_list_scroll_whole_page = "yes";
          lines_scrolled = "1";
          message_delay_time = "1";
          playlist_shorten_total_times = "yes";
          playlist_display_mode = "columns";
          browser_display_mode = "columns";
          search_engine_display_mode = "columns";
          playlist_editor_display_mode = "columns";
          autocenter_mode = "yes";
          centered_cursor = "yes";
          user_interface = "classic";
          follow_now_playing_lyrics = "yes";
          locked_screen_width_part = "50";
          ask_for_locked_screen_width_part = "yes";
          display_bitrate = "no";
          external_editor = "nano";
          main_window_color = "default";
          startup_screen = "playlist";

          # PROGRESS BAR
          # ---
          progressbar_look = "━━━";
          #progressbar_look = "▃▃▃";
          progressbar_elapsed_color = "5";
          progressbar_color = "black";

          # UI VISIBILITY
          # ---
          header_visibility = "no";
          statusbar_visibility = "yes";
          titles_visibility = "yes";
          enable_window_title = "yes";

          # COLORS
          # ---
          statusbar_color = "white";
          color1 = "white";
          color2 = "blue";

          # UI APPEARANCE
          # ---
          now_playing_prefix = "$b$2$7 ";
          now_playing_suffix = "  $/b$8";
          current_item_prefix = "$b$7$/b$3 ";
          current_item_suffix = "  $8";

          song_columns_list_format = "(50)[]{t|fr:Title} (0)[magenta]{a}";

          song_list_format = " {%t $R   $8%a$8}|{%f $R   $8%l$8} $8";

          song_status_format =
            "$b$6$7[$8      $7]$6 $2 $7{$8 %b }|{$8 %t }|{$8 %f }$7 $8";

          song_window_title_format = "Now Playing ..";
        };
      };
    };
  };
}
