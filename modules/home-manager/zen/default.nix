{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;

    profiles.hao = {
      extensions.packages = with inputs.firefox-addons.packages."x86_64-linux"; [
        bitwarden
        cookie-quick-manager
        multi-account-containers
        return-youtube-dislikes
        ublock-origin
      ];

      settings = {
        # Never ask for password
        "signon.rememberSignons" = false;

        # DNS over HTTPS
        "network.trr.mode" = 3;

        # Disable alt key to show menu
        "ui.key.menuAccessKey" = 17;
        "ui.key.menuAccessKeyFocuses" = false;

        "dom.security.https_only_mode" = true;
        "dom.private-attribution.submission.enabled" = false;
        "extensions.pocket.enabled" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "middlemouse.paste" = false;

        "full-screen-api.warning.delay" = 0;
        "full-screen-api.warning.timeout" = 0;

        "zen.theme.content-element-separation" = 0;

        "browser.ai.control.default" = false;
        "browser.ai.control.linkPreviewKeyPoints" = false;
        "browser.ai.control.pdfjsAltText" = false;
        "browser.ai.control.sidebarChatbot" = false;
        "browser.ai.control.smartTabGroups" = false;
        "browser.ai.control.translations" = false;
      };

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

          "MyNixOS" = {
            urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@mn"];
          };

          "Crate" = {
            urls = [{template = "https://crates.io/search?q={searchTerms}";}];
            definedAliases = ["@crate"];
          };

          "Docs.rs" = {
            urls = [{template = "https://docs.rs/{searchTerms}/latest/{searchTerms}";}];
            definedAliases = ["@docs"];
          };

          "Rust std" = {
            urls = [{template = "https://doc.rust-lang.org/std/?search={searchTerms}";}];
            definedAliases = ["@std"];
          };

          "Youtube" = {
            urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
            definedAliases = ["@yt"];
          };

          "google".metaData.alias = "@g"; # builtin engines only support specifying one additional alias

          "bing".metaData.hidden = true;
          "wikipedia".metaData.hidden = true;
        };

        default = "ddg";
        force = true;
        order = ["ddg" "google" "Youtube" "Nix Packages" "MyNixOS" "Crate" "Docs.rs" "Rust std"];
      };
    };
  };
}
