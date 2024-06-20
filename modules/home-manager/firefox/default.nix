{inputs, ...}: {
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
    };
  };
}
