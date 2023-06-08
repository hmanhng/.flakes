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
          "browser.toolbars.bookmarks.visibility" = "always";
          "browser.tabs.inTitlebar" = 0;
          "browser.aboutConfig.showWarning" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
          "media.ffmpeg.vaapi.enabled" = true;
          "extensions.autoDisableScopes" = 0;
        };
      };
    };
    profiles.default = {
      extensions = (with pkgs.nur.repos.rycee.firefox-addons; [
        privacy-badger
        tabcenter-reborn
        ublock-origin
        translate-web-pages
        i-dont-care-about-cookies
        enhancer-for-youtube
        stylus
      ]) ++ (with pkgs.firefox-addons;[
        dashlane
        default-zoom
      ]);
      search.engines = {
        "Nix Packages" = {
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "channel"; value = "unstable"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "np" ];
        };
        "Nix Options" = {
          urls = [{
            template = "https://search.nixos.org/options";
            params = [
              { name = "type"; value = "packages"; }
              { name = "channel"; value = "unstable"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "no" ];
        };

        "NixOS Wiki" = {
          urls = [{ template = "https://nixos.wiki/index.php?search={searchTerms}"; }];
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "nw" ];
        };
      };
      settings = {
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
