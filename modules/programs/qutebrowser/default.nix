{ pkgs, config, lib, theme, ... }:
let cfg = config.modules.programs.qutebrowser;
in with lib; {
  options.modules.programs.qutebrowser = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "enable qutebrowser";
    };
  };

  config = mkIf cfg.enable {
    programs.qutebrowser = {
      enable = true;
      package = pkgs.qutebrowser.override { enableWideVine = true; };
      loadAutoconfig = false;
      keyBindings = {
        insert = {
          "<Ctrl-v>" = "spawn mpv {url}";
          "<Ctrl-C>" = "yank selection";
        };
      };
      keyMappings = { "<Ctrl-c>" = "<Escape>"; };
      searchEngines = {
        g = "https://www.google.com/search?hl=en&q={}";
        ddg = "https://duckduckgo.com/?t=ffab&q={}";
      };
      extraConfig = ''
        c.statusbar.padding = {"top": 1, "bottom": 1, "left": 0, "right": 0}
        c.tabs.indicator.padding = {"top": 2, "bottom": 2, "left": 0, "right": 4}
        c.tabs.padding = {"top": 7, "bottom": 7, "left": 14, "right": 14}
      '';
      settings = with theme.colors; {
        # ╔══════════════════════════════════════════════════════════╗
        # ║ settings                                                 ║
        # ╚══════════════════════════════════════════════════════════╝
        backend = "webengine";
        scrolling.smooth = false;
        url = {
          default_page = "https://sachnr.github.io";
          start_pages = "https://sachnr.github.io";
        };
        auto_save.session = true;
        tabs = {
          position = "top";
          title.format = "{index}: {audio}{current_title}";
          title.format_pinned = "{index}: {audio}{current_title}";
          indicator = { width = 4; };
        };
        statusbar = {
          show = "always";
          position = "bottom";
          widgets = [ "keypress" "url" "scroll" "history" "tabs" "progress" ];
        };
        fonts = {
          default_size = "11pt";
          default_family = [ "${theme.settings.font}" ];
          completion.category = "bold default_size default_family";
          completion.entry = "default_size default_family";
          downloads = "default_size default_family";
          hints = "bold default_size default_family";
          keyhint = "default_size default_family";
          messages = {
            error = "default_size default_family";
            info = "default_size default_family";
            warning = "default_size default_family";
          };
          prompts = "default_size default_family";
          statusbar = "default_size default_family";
          tabs.selected = "default_size default_family";
          tabs.unselected = "default_size default_family";
          web = {
            family = {
              sans_serif = theme.settings.font;
              serif = theme.settings.font;
              standard = theme.settings.font;
              fixed = theme.settings.fontmonospace;
            };
            size.default = 16;
            size.default_fixed = 13;
          };
        };
        # ╔══════════════════════════════════════════════════════════╗
        # ║           privacy                                        ║
        # ╚══════════════════════════════════════════════════════════╝
        content = {
          blocking = {
            enabled = true;
            hosts.block_subdomains = true;
            adblock.lists = [
              "https://easylist.to/easylist/easylist.txt"
              "https://easylist.to/easylist/easyprivacy.txt"
            ];
            method = "auto";
          };
          cookies.accept = "no-3rdparty";
          headers.do_not_track = true;
          webrtc_ip_handling_policy = "default-public-interface-only";
          site_specific_quirks.enabled = false;
          notifications.enabled = true;
        };
        # ╔══════════════════════════════════════════════════════════╗
        # ║           colors                                         ║
        # ╚══════════════════════════════════════════════════════════╝
        colors = {
          #     ╞══════════════════════════════════════════════════════════╡
          webpage = { darkmode = { enabled = true; }; };
          tabs = {
            even = {
              bg = primary.background;
              fg = normal.gray;
            };
            odd = {
              bg = primary.background;
              fg = normal.gray;
            };
            bar.bg = normal.black;
            selected = {
              even = {
                bg = primary.selection;
                fg = primary.foreground;
              };
              odd = {
                bg = primary.selection;
                fg = primary.foreground;
              };
            };
            pinned = {
              even = {
                bg = normal.green;
                fg = primary.foreground;
              };
              odd = {
                bg = normal.green;
                fg = primary.foreground;
              };
            };
            indicator = {
              start = normal.blue;
              stop = normal.blue;
              error = normal.red;
            };
          };
          #     ╞══════════════════════════════════════════════════════════╡
          contextmenu = {
            menu = {
              fg = primary.foreground;
              bg = primary.background;
            };
            disabled = {
              fg = normal.gray;
              bg = primary.background;
            };
            selected = {
              fg = primary.foreground;
              bg = primary.selection;
            };
          };
          #     ╞══════════════════════════════════════════════════════════╡
          statusbar = {
            normal = {
              fg = primary.foreground;
              bg = normal.black;
            };
            insert = {
              fg = bright.purple;
              bg = normal.black;
            };
            command = {
              fg = bright.green;
              bg = normal.black;
            };
            passthrough = {
              fg = normal.gray;
              bg = normal.black;
            };
            private = {
              fg = normal.purple;
              bg = normal.black;
            };
            command.private = {
              fg = bright.green;
              bg = normal.black;
            };
            url = {
              fg = primary.foreground;
              error.fg = normal.red;
              warn.fg = bright.yellow;
              hover.fg = normal.green;
              success.http.fg = primary.foreground;
              success.https.fg = primary.foreground;
            };
            progress.bg = normal.green;
            caret = {
              fg = primary.foreground;
              bg = normal.black;
              selection = {
                fg = primary.foreground;
                bg = primary.selection;
              };
            };
          };
          #     ╞══════════════════════════════════════════════════════════╡
          completion = {
            fg = primary.foreground;
            odd.bg = primary.selection;
            even.bg = primary.selection;
            category = {
              fg = primary.foreground;
              bg = primary.background;
              border = {
                top = normal.black;
                bottom = normal.black;
              };
            };
            item = {
              selected = {
                fg = primary.foreground;
                bg = primary.selection;
                border = {
                  top = normal.black;
                  bottom = normal.black;
                };
                match.fg = bright.green;
              };
            };
            match.fg = bright.green;
            scrollbar = {
              fg = primary.selection;
              bg = primary.background;
            };
          };
          #     ╞══════════════════════════════════════════════════════════╡
          hints = {
            bg = primary.background;
            fg = normal.gray;
            match.fg = primary.foreground;
          };
          #     ╞══════════════════════════════════════════════════════════╡
          keyhint = {
            bg = primary.selection;
            fg = primary.foreground;
            suffix.fg = normal.gray;
          };
          #     ╞══════════════════════════════════════════════════════════╡
          messages = {
            error = {
              fg = normal.red;
              bg = primary.selection;
              border = normal.red;
            };
            warning = {
              fg = bright.yellow;
              bg = primary.selection;
              border = normal.yellow;
            };
            info = {
              fg = bright.blue;
              bg = primary.selection;
              border = bright.blue;
            };
          };
          #     ╞══════════════════════════════════════════════════════════╡
          prompts = {
            fg = primary.foreground;
            bg = primary.selection;
            border = normal.black;
            selected = {
              bg = primary.selection;
              fg = primary.foreground;
            };
          };
          #     ╞══════════════════════════════════════════════════════════╡
          downloads = {
            bar.bg = normal.green;
            start = {
              fg = primary.foreground;
              bg = primary.selection;
            };
            stop = {
              fg = normal.gray;
              bg = primary.selection;
            };
            error = {
              fg = normal.red;
              bg = primary.selection;
            };
          };
        };
      };
    };
  };
}
