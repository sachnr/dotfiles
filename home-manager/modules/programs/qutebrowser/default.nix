{
  pkgs,
  config,
  lib,
  user,
  ...
}: let
  cfg = config.modules.programs.qutebrowser;
  theme = import ../../theme {};
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
            "<Space>q" = "tab-close";
            "<Ctrl-v>" = "spawn mpv {url}";
            "<Ctrl-C>" = "yank selection";
            "<Tab>" = "tab-next";
            "<Shift-Tab>" = "tab-prev";
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
          url = {
            default_page = "file:///home/${user}/.config/startpage/index.html";
            start_pages = "file:///home/${user}/.config/startpage/index.html";
          };
          auto_save.session = true;
          tabs = {
            position = "top";
            title.format = "{index}: {audio}{current_title}";
            title.format_pinned = "{index}: {audio}{current_title}";
            max_width = 220;
            min_width = 140;
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
                bg = xcolor0;
                fg = xcolor7;
              };
              odd = {
                bg = xcolor0;
                fg = xcolor7;
              };
              bar.bg = base00;
              selected = {
                even = {
                  bg = base01;
                  fg = xcolor15;
                };
                odd = {
                  bg = base01;
                  fg = xcolor15;
                };
              };
              pinned = {
                even = {
                  bg = xcolor6;
                  fg = xcolor15;
                };
                odd = {
                  bg = xcolor6;
                  fg = xcolor15;
                };
              };
              indicator = {
                start = xcolor4;
                stop = xcolor4;
                error = xcolor9;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            contextmenu = {
              menu = {
                fg = xcolor15;
                bg = xcolor0;
              };
              disabled = {
                fg = xcolor7;
                bg = xcolor0;
              };
              selected = {
                fg = xcolor15;
                bg = base01;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            statusbar = {
              normal = {
                fg = xcolor15;
                bg = base00;
              };
              insert = {
                fg = xcolor13;
                bg = base00;
              };
              command = {
                fg = xcolor10;
                bg = base00;
              };
              passthrough = {
                fg = xcolor7;
                bg = base00;
              };
              private = {
                fg = xcolor5;
                bg = base00;
              };
              command.private = {
                fg = xcolor10;
                bg = base00;
              };
              url = {
                fg = xcolor15;
                error.fg = xcolor9;
                warn.fg = xcolor11;
                hover.fg = xcolor6;
                success.http.fg = xcolor15;
                success.https.fg = xcolor15;
              };
              progress.bg = xcolor6;
              caret = {
                fg = xcolor15;
                bg = base00;
                selection = {
                  fg = xcolor15;
                  bg = base01;
                };
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            completion = {
              fg = xcolor15;
              odd.bg = base01;
              even.bg = base01;
              category = {
                fg = xcolor15;
                bg = xcolor0;
                border = {
                  top = base00;
                  bottom = base00;
                };
              };
              item = {
                selected = {
                  fg = xcolor15;
                  bg = base02;
                  border = {
                    top = base00;
                    bottom = base00;
                  };
                  match.fg = xcolor14;
                };
              };
              match.fg = xcolor14;
              scrollbar = {
                fg = base02;
                bg = base01;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            hints = {
              bg = xcolor0;
              fg = xcolor7;
              match.fg = xcolor15;
            };
            #     ╞══════════════════════════════════════════════════════════╡
            keyhint = {
              bg = base01;
              fg = xcolor15;
              suffix.fg = xcolor7;
            };
            #     ╞══════════════════════════════════════════════════════════╡
            messages = {
              error = {
                fg = xcolor9;
                bg = base01;
                border = xcolor9;
              };
              warning = {
                fg = xcolor11;
                bg = base01;
                border = xcolor3;
              };
              info = {
                fg = xcolor12;
                bg = base01;
                border = xcolor12;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            prompts = {
              fg = xcolor15;
              bg = base01;
              border = base00;
              selected = {
                bg = base01;
                fg = xcolor15;
              };
            };
            #     ╞══════════════════════════════════════════════════════════╡
            downloads = {
              bar.bg = xcolor6;
              start = {
                fg = xcolor15;
                bg = base01;
              };
              stop = {
                fg = xcolor7;
                bg = base01;
              };
              error = {
                fg = xcolor9;
                bg = base01;
              };
            };
          };
        };
      };
    };
  }
