{ pkgs, ... }:
{
  xdg.configFile."qutebrowser/userscripts/translate".source = ./translate;
  programs = {
    qutebrowser = {
      enable = true;
      aliases = {
        q = "quit";
        w = "session-save";
        wq = "quit --save";
      };
      greasemonkey = [
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/2ff7742d56fa626b4023a365a85e11750245b27c/youtube_adblock.js";
          sha256 = "sha256-AyD9VoLJbKPfqmDEwFIEBMl//EIV/FYnZ1+ona+VU9c=";
        })
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/4cb4b6dfcb31545f88b2fcae87f5fde33157fd72/youtube_sponsorblock.js";
          sha256 = "sha256-nwNade1oHP+w5LGUPJSgAX1+nQZli4Rhe8FFUoF5mLE=";
        })
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/69df2b309eae2af18bb1d1ff1790f1d92d8e6a5d/youtube_shorts_block.js";
          sha256 = "sha256-e9qCSAuEMoNivepy7W/W5F9D1PJZrPAJoejsBi9ejiY=";
        })
      ];
      keyBindings = {
        normal = {
          "." = "cmd-set-text :";
          ",D" = "hint links spawn foot yt-dlp {hint-url}";
          ",m" = "hint links spawn mpv --profile=M60 {hint-url}";
          "ch" = "history-clear";
          "t" = "cmd-set-text -s :open -t";
          "xb" = "config-cycle statusbar.show always never";
          "xt" = "config-cycle tabs.show always never";
          "xx" = "config-cycle statusbar.show always never;; config-cycle tabs.show always never";
          ";t" = "hint userscript link translate";
          ";T" = "hint userscript all translate --text";
          ",t" = "spawn --userscript translate";
          ",T" = "spawn --userscript translate --text";
          "<Ctrl+r>" = "restart";
        };
      };
      searchEngines = {
        "DEFAULT" = "https://www.google.com/search?q={}";
        "aw" = "https://wiki.archlinux.org/?search={}";
        "re" = "https://www.reddit.com/r/{}";
        "ub" = "https://www.urbandictionary.com/define.php?term={}";
        "wiki" = "https://en.wikipedia.org/wiki/{}";
        "yt" = "https://www.youtube.com/results?search_query={}";
        "np" = "https://search.nixos.org/packages?channel=unstable&query={}";
        "no" = "https://search.nixos.org/options?channel=unstable&query={}";
      };
      quickmarks = { };
      settings = {
        fonts = {
          default_family = "Iosevka Term";
          default_size = "15pt";
        };
        downloads.location.directory = "~/Downloads";
        statusbar.show = "always";
        tabs.show = "always";
        url.default_page = "${../firefox/homepage.html}";
        url.start_pages = "${../firefox/homepage.html}";
        zoom.default = "100";

        content.blocking = {
          adblock.lists = [
            "https://easylist.to/easylist/easylist.txt"
            "https://easylist.to/easylist/easyprivacy.txt"
            "https://abpvn.com/filter/abpvn-O2ghOE.txt"
          ];
          hosts.lists = [
            "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
          ];
          method = "both";
        };
      };
      # extraConfig = ''
      #   # ============================== Colors ============================== {{{
      #   import os
      #   from urllib.request import urlopen
      #
      #   if not os.path.exists(config.configdir / "theme.py"):
      #     theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
      #     with urlopen(theme) as themehtml:
      #       with open(config.configdir / "theme.py", "a") as file:
      #         file.writelines(themehtml.read().decode("utf-8"))
      #
      #   if os.path.exists(config.configdir / "theme.py"):
      #     import theme
      #     theme.setup(c, 'macchiato', True)
      #   # }}}
      # '';
    };
  };
}
