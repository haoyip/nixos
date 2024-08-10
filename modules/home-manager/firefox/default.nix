{
  pkgs,
  inputs,
  ...
}: {
  programs.firefox = {
    enable = true;

    profiles.hao = {
      extensions = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        cookie-quick-manager
        disable-javascript
        multi-account-containers
        return-youtube-dislikes
        sidebery
        ublock-origin
        youtube-shorts-block
      ];

      settings = {
        # Enable custom css
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

        # Never ask for password
        "signon.rememberSignons" = false;

        # DNS over HTTPS
        "network.trr.mode" = 3;

        # Disable alt key to show menu
        "ui.key.menuAccessKey" = 17;
        "ui.key.menuAccessKeyFocuses" = false;

        "browser.download.panel.shown" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "dom.security.https_only_mode" = true;
        "extensions.pocket.enabled" = false;
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "middlemouse.paste" = false;

        "full-screen-api.transition-duration.enter" = "0 0";
        "full-screen-api.transition-duration.leave" = "0 0";
        "full-screen-api.transition.timeout" = 0;
        "full-screen-api.warning.delay" = 0;
        "full-screen-api.warning.timeout" = 0;
      };

      userChrome = ''
        #TabsToolbar {
          visibility: collapse;
        }

        #sidebar-box #sidebar-header {
          display: none !important;
        }
      '';

      search = {
        engines = {
          "Nix Packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];

            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };

          "NixOS Wiki" = {
            urls = [{template = "https://wiki.nixos.org/index.php?search={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = ["@nw"];
          };

          "Google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias

          "Bing".metaData.hidden = true;
          "Wikipedia (en)".metaData.hidden = true;
        };

        default = "DuckDuckGo";
        force = true;
        order = ["DuckDuckGo" "Google"];
      };
    };
  };
}
