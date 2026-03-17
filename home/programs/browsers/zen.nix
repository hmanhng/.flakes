{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    languagePacks = [ "en-US" ];
    setAsDefaultBrowser = true;

    policies =
      let
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );

        mkPluginUrl = id: "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";

        mkExtensionEntry =
          {
            id,
            pinned ? false,
          }:
          let
            base = {
              install_url = mkPluginUrl id;
              installation_mode = "force_installed";
            };
          in
          if pinned then base // { default_area = "navbar"; } else base;

        mkExtensionSettings = builtins.mapAttrs (
          _: entry: if builtins.isAttrs entry then entry else mkExtensionEntry { id = entry; }
        );
      in
      {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true; # save webs for later reading
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        SanitizeOnShutdown = {
          FormData = true;
          Cache = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "wappalyzer@crunchlabz.com" = mkExtensionEntry {
            id = "wappalyzer";
            pinned = true;
          };
          "uBlock0@raymondhill.net" = mkExtensionEntry {
            id = "ublock-origin";
            pinned = true;
          };
          "{446900e4-71c2-419f-a6a7-df9c091e268b}" = "bitwarden-password-manager";
          "{036a55b4-5e72-4d05-a06c-cba2dfcc134a}" = "traduzir-paginas-web";
          "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = "github-file-icons";
          # "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = "return-youtube-dislikes";
          "{74145f27-f039-47ce-a470-a662b129930a}" = "clearurls";
          "github-no-more@ihatereality.space" = "github-no-more";
          "github-repository-size@pranavmangal" = "gh-repo-size";
          # "firefox-extension@steamdb.info" = "steam-database";
          # "@searchengineadremover" = "searchengineadremover";
          # "jid1-BoFifL9Vbdl2zQ@jetpack" = "decentraleyes";
          # "{b86e4813-687a-43e6-ab65-0bde4ab75758}" = "localcdn-fork-of-decentraleyes";
          # "trackmenot@mrl.nyu.edu" = "trackmenot";
          # "{861a3982-bb3b-49c6-bc17-4f50de104da1}" = "custom-user-agent-revived";
          "sponsorBlocker@ajay.app" = "sponsorblock";
        };
        Preferences = mkLockedAttrs {
          "browser.aboutConfig.showWarning" = false;
          "browser.tabs.warnOnClose" = false;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
          # Disable swipe gestures (Browser:BackOrBackDuplicate, Browser:ForwardOrForwardDuplicate)
          # "browser.gesture.swipe.left" = "";
          # "browser.gesture.swipe.right" = "";
          "browser.tabs.hoverPreview.enabled" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.topsites.contile.enabled" = false;

          "privacy.resistFingerprinting" = true;
          "privacy.resistFingerprinting.randomization.canvas.use_siphash" = true;
          "privacy.resistFingerprinting.randomization.daily_reset.enabled" = true;
          "privacy.resistFingerprinting.randomization.daily_reset.private.enabled" = true;
          "privacy.resistFingerprinting.block_mozAddonManager" = true;
          "privacy.spoof_english" = 1;

          "privacy.firstparty.isolate" = true;
          "network.cookie.cookieBehavior" = 5;
          "dom.battery.enabled" = false;

          "gfx.webrender.all" = true;
          "network.http.http3.enabled" = true;
          "network.socket.ip_addr_any.disabled" = true; # disallow bind to 0.0.0.0
        };
      };

    profiles.default = rec {
      settings = {
        "zen.workspaces.continue-where-left-off" = true;
        "zen.workspaces.natural-scroll" = true;
        "zen.view.compact.hide-tabbar" = true;
        "zen.view.compact.hide-toolbar" = true;
        "zen.view.compact.animate-sidebar" = false;
        "zen.view.use-single-toolbar" = false;
        "zen.welcome-screen.seen" = true;
        "zen.urlbar.behavior" = "float";
      };

      mods = [
        "7190e4e9-bead-4b40-8f57-95d852ddc941" # Tab title fixes
        "803c7895-b39b-458e-84f8-a521f4d7a064" # Hide Inactive Workspaces
        "906c6915-5677-48ff-9bfc-096a02a72379" # Floating Status Bar
        "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
        "c6813222-6571-4ba6-8faf-58f3343324f6" # Disable Rounded Corners
        "c8d9e6e6-e702-4e15-8972-3596e57cf398" # Zen Back Forward
        "cb15abdb-0514-4e09-8ce5-722cf1f4a20f" # Hide Extension Name
        "e122b5d9-d385-4bf8-9971-e137809097d0" # No Top Sites
        "f7c71d9a-bce2-420f-ae44-a64bd92975ab" # Better Unloaded Tabs
        "642854b5-88b4-4c40-b256-e035532109df" # Transparent Zen
      ];

      # bookmarks = {
      #   force = true;
      #   settings = [
      #     {
      #       name = "Nix sites";
      #       toolbar = true;
      #       bookmarks = [
      #         {
      #           name = "homepage";
      #           url = "https://nixos.org/";
      #         }
      #         {
      #           name = "wiki";
      #           tags = [
      #             "wiki"
      #             "nix"
      #           ];
      #           url = "https://wiki.nixos.org/";
      #         }
      #       ];
      #     }
      #   ];
      # };

      pinsForce = true;
      pins = {
        "GitHub" = {
          id = "48e8a119-5a14-4826-9545-91c8e8dd3bf6";
          workspace = spaces."hmanhng".id;
          url = "https://github.com";
          position = 101;
          isEssential = false;
        };
        # "WhatsApp Web" = {
        #   id = "1eabb6a3-911b-4fa9-9eaf-232a3703db19";
        #   workspace = spaces."Rendezvous".id;
        #   url = "https://web.whatsapp.com/";
        #   position = 102;
        #   isEssential = false;
        # };
        # "Telegram Web" = {
        #   id = "5065293b-1c04-40ee-ba1d-99a231873864";
        #   url = "https://web.telegram.org/k/";
        #   position = 103;
        #   isEssential = true;
        # };
      };

      containersForce = true;
      containers = {
        Shopping = {
          color = "yellow";
          icon = "dollar";
          id = 2;
        };
      };

      spacesForce = true;
      spaces = {
        "hmanhng" = {
          id = "572910e1-4468-4832-a869-0b3a93e2f165";
          icon = "🎭";
          position = 1000;
        };
        "Research" = {
          id = "ec287d7f-d910-4860-b400-513f269dee77";
          icon = "💌";
          position = 1001;
        };
        "Shopping" = {
          id = "2441acc9-79b1-4afb-b582-ee88ce554ec0";
          icon = "💸";
          container = containers."Shopping".id;
          position = 1002;
        };
      };

      search = {
        force = true;
        default = "google";
        privateDefault = "ddg";
        engines =
          let
            nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          in
          {
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
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "np" ];
            };

            "Nix Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "channel";
                      value = "unstable";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "no" ];
            };

            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                    {
                      name = "release";
                      value = "master"; # unstable
                    }
                  ];
                }
              ];
              icon = nixSnowflakeIcon;
              definedAliases = [ "hmop" ];
            };

            "ddg" = {
              urls = [
                {
                  template = "https://duckduckgo.com";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              definedAliases = [
                "@duck"
                "@ddg"
                "@dck"
                "@dckk"
              ];
            };

            bing.metaData.hidden = "true";
          };
      };
    };
  };
}
