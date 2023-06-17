{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.wrapFirefox pkgs.firefox-unwrapped {
      extraPolicies = {
        CaptivePortal = false;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableFirefoxAccounts = false;
        NoDefaultBookmarks = true;
        DisableProfileImport = true;
        PasswordManagerEnabled = false;
        UserMessaging = {
          WhatsNew = false;
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
        };

        DisplayBookmarksToolbar = true;
        Preferences = {
          "browser.tabs.inTitlebar" = 0;
          "browser.aboutConfig.showWarning" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "media.eme.enabled" = true; # Enable DRM
          "extensions.autoDisableScopes" = 0; # Enable extensions install default
          "extensions.htmlaboutaddons.recommendations.enabled" = false; # Disable recommendations extensions
        };
      };
    };
    profiles.default = {
      extensions = (with pkgs.nur.repos.rycee.firefox-addons; [
        # duckduckgo-privacy-essentials
        enhancer-for-youtube
        i-dont-care-about-cookies
        privacy-badger
        stylus
        tabcenter-reborn
        translate-web-pages
        ublock-origin
      ]) ++ (with pkgs.firefox-addons;[
        dashlane-firefox
        default-zoom-firefox
      ]);
      search = {
        force = true;
        default = "Google";
        engines = {
          "Nix Packages" = {
            urls = [{ template = "https://search.nixos.org/packages?channel=unstable&query={searchTerms}"; }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "np" ];
          };
          "Nix Options" = {
            urls = [{ template = "https://search.nixos.org/options?channel=unstable&query={searchTerms}"; }];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "no" ];
          };

          "NixOS Wiki" = {
            urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
            iconUpdateURL = "https://nixos.wiki/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "nw" ];
          };
          "Google".metaData.alias = "gg";
          "DuckDuckGo".metaData.alias = "duck";
          "Wikipedia (en)".metaData.hidden = true;
          "Amazon.com".metaData.hidden = true;
          "Bing".metaData.hidden = true;
          "eBay".metaData.hidden = true;
        };
      };
      settings = {
        "browser.toolbars.bookmarks.visibility" = "always"; # Show bookmarks
        "browser.startup.homepage" = "file://${./homepage.html}";
        "extensions.activeThemeID" = "firefox-compact-light@mozilla.org";
      };
      # userChrome = builtins.readFile ./userChrome.css;
    };
  };
  home.file.".mozilla/firefox/default/chrome" = {
    source = ./chrome;
    recursive = true;
  };
}
