{
  pkgs,
  lib,
  config,
  user,
  theme,
  ...
}: let
  cfg = config.modules.programs.firefox;
  mozillaCfg = ''
    var {classes:Cc,interfaces:Ci,utils:Cu} = Components;
    /* set new tab page */
    try {
      Cu.import("resource:///modules/AboutNewTab.jsm");
      var newTabURL = "https://sachnr.github.io/";
      AboutNewTab.newTabURL = newTabURL;
    } catch(e){Cu.reportError(e);}
  '';
in
  with lib; {
    options.modules.programs.firefox = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "enable firefox";
      };
    };

    config = mkIf cfg.enable {
      programs.firefox = {
        enable = true;
        package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
          extraPolicies = {
            ExtensionSettings = {};
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            FirefoxHome = {
              Pocket = false;
              Snippets = false;
            };
          };
          extraPrefs = mozillaCfg;
        };
        profiles = {
          ${user} = {
            extensions = with pkgs.nur.repos.rycee.firefox-addons; [
              darkreader
              betterttv
              ublock-origin
              df-youtube
              cookie-autodelete
              # decentraleyes
              return-youtube-dislikes
              lovely-forks
            ];

            settings = {
              "browser.startup.homepage" = "sachnr.github.io";
              "browser.search.region" = "IN";
              "general.useragent.locale" = "en-US";
            };
            # Extra preferences to add to user.js
            extraConfig = ''
              user_pref("media.hardware-video-decoding.force-enabled", true);
              user_pref("media.hardware-video-decoding.enabled", true);
              user_pref("gfx.webrender.all", true);
              user_pref("general.config.filename", "mozilla.cfg");
              user_pref("geo.provider.use_gpsd", false);
              user_pref("geo.provider.use_geoclue", false);
              user_pref("datareporting.policy.dataSubmissionEnabled", false);
              user_pref("datareporting.healthreport.uploadEnabled", false);
              user_pref("toolkit.telemetry.unified", false);
              user_pref("toolkit.telemetry.enabled", false);
              user_pref("toolkit.telemetry.server", "data:,");
              user_pref("toolkit.telemetry.archive.enabled", false);
              user_pref("toolkit.telemetry.newProfilePing.enabled", false);
              user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
              user_pref("toolkit.telemetry.updatePing.enabled", false);
              user_pref("toolkit.telemetry.bhrPing.enabled", false);
              user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
              user_pref("toolkit.telemetry.coverage.opt-out", true);
              user_pref("toolkit.coverage.opt-out", true);
              user_pref("toolkit.coverage.endpoint.base", "");
              user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
              user_pref("browser.ping-centre.telemetry", false);
              user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
              user_pref("browser.newtabpage.activity-stream.telemetry", false);
              user_pref("app.shield.optoutstudies.enabled", false);
              user_pref("browser.search.suggest.enabled", false);
              user_pref("browser.urlbar.suggest.searches", false);
            '';
            userChrome = import ./userChrome-css.nix {};
            userContent = import ./userContent-css.nix {};
          };
        };
      };
    };
  }
