{
  pkgs,
  config,
  lib,
  user,
  theme,
  ...
}: let
  cfg = config.modules.programs.qutebrowser;
in
  with lib; {
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
        loadAutoconfig = false;
        keyBindings = {
          normal = {
            "<Ctrl-v>" = "spawn mpv {url}";
            "<Ctrl-C>" = "yank selection";
          };
        };
        keyMappings = {
          "<Ctrl-c>" = "<Escape>";
        };
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
          scrolling.smooth = true;
          url = {
            default_page = "file:///home/${user}/.config/startpage/index.html";
            start_pages = "file:///home/${user}/.config/startpage/index.html";
          };
          auto_save.session = true;
          tabs = {
            position = "top";
            title.format = "{index}: {audio}{current_title}";
            title.format_pinned = "{index}: {audio}{current_title}";
            indicator = {
              width = 4;
            };
          };
          statusbar = {
            show = "always";
            position = "bottom";
            widgets = ["keypress" "url" "scroll" "history" "tabs" "progress"];
          };
          fonts = {
            default_size = "11pt";
            default_family = ["${name.font}"];
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
                sans_serif = name.font;
                serif = name.font;
                standard = name.font;
                fixed = name.fontmonospace;
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
              adblock.lists = ["https://easylist.to/easylist/easylist.txt" "https://easylist.to/easylist/easyprivacy.txt"];
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
            tabs = {
              even = {
                bg = background;
                fg = gray;
              };
              odd = {
                bg = background;
                fg = gray;
              };
              bar.bg = black;
              selected = {
                even = {
                  bg = selection;
                  fg = foreground;
                };
                odd = {
                  bg = selection;
                  fg = foreground;
                };
              };
              pinned = {
                even = {
                  bg = green;
                  fg = foreground;
                };
                odd = {
                  bg = green;
                  fg = foreground;
                };
              };
              indicator = {
                start = blue;
                stop = blue;
                error = red;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            contextmenu = {
              menu = {
                fg = foreground;
                bg = background;
              };
              disabled = {
                fg = gray;
                bg = background;
              };
              selected = {
                fg = foreground;
                bg = selection;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            statusbar = {
              normal = {
                fg = foreground;
                bg = black;
              };
              insert = {
                fg = brightpurple;
                bg = black;
              };
              command = {
                fg = brightgreen;
                bg = black;
              };
              passthrough = {
                fg = gray;
                bg = black;
              };
              private = {
                fg = purple;
                bg = black;
              };
              command.private = {
                fg = brightgreen;
                bg = black;
              };
              url = {
                fg = foreground;
                error.fg = red;
                warn.fg = brightyellow;
                hover.fg = green;
                success.http.fg = foreground;
                success.https.fg = foreground;
              };
              progress.bg = green;
              caret = {
                fg = foreground;
                bg = black;
                selection = {
                  fg = foreground;
                  bg = selection;
                };
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            completion = {
              fg = foreground;
              odd.bg = selection;
              even.bg = selection;
              category = {
                fg = foreground;
                bg = background;
                border = {
                  top = black;
                  bottom = black;
                };
              };
              item = {
                selected = {
                  fg = foreground;
                  bg = selection;
                  border = {
                    top = black;
                    bottom = black;
                  };
                  match.fg = brightgreen;
                };
              };
              match.fg = brightgreen;
              scrollbar = {
                fg = selection;
                bg = background;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            hints = {
              bg = background;
              fg = gray;
              match.fg = foreground;
            };
            #     ╞══════════════════════════════════════════════════════════╡
            keyhint = {
              bg = selection;
              fg = foreground;
              suffix.fg = gray;
            };
            #     ╞══════════════════════════════════════════════════════════╡
            messages = {
              error = {
                fg = red;
                bg = selection;
                border = red;
              };
              warning = {
                fg = brightyellow;
                bg = selection;
                border = yellow;
              };
              info = {
                fg = brightblue;
                bg = selection;
                border = brightblue;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            prompts = {
              fg = foreground;
              bg = selection;
              border = black;
              selected = {
                bg = selection;
                fg = foreground;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            downloads = {
              bar.bg = green;
              start = {
                fg = foreground;
                bg = selection;
              };
              stop = {
                fg = gray;
                bg = selection;
              };
              error = {
                fg = red;
                bg = selection;
              };
            };
          };
        };
      };
    };
  }
