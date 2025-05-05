{pkgs, ...}: {
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
          url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/1d1be041a65c251692ee082eda64d2637edf6444/youtube_sponsorblock.js";
          sha256 = "sha256-e3QgDPa3AOpPyzwvVjPQyEsSUC9goisjBUDMxLwg8ZE=";
        })
        (pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/afreakk/greasemonkeyscripts/bebaf31afa8b0f0ef3c0248faafabbd9bb7a1d54/youtube_adblock.js";
          sha256 = "sha256-CaG6lw3Tg34BtIhL3MzAZSx/J6khCEBKUydHKhTtiHY=";
        })
      ];
      keyBindings = {
        normal = {
          "." = "cmd-set-text :";
          ",D" = "hint links spawn foot yt-dlp {hint-url}";
          ",d" = "hint links spawn xdman {hint-url}";
          ",m" = "hint links spawn mpv --profile=M60 {hint-url}";
          ",p" = "set content.proxy http://localhost:8080/";
          ",P" = "set content.proxy system";
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
      quickmarks = {};
      settings = {
        fonts = {
          default_family = "Iosevka Term";
          default_size = "15pt";
        };
        downloads.location.directory = "~/Downloads";
        editor.command = ["emacsclient" "-c" "-a" "emacs" "{file}"];
        statusbar.show = "always";
        tabs.show = "always";
        url.default_page = "${../firefox/homepage.html}";
        url.start_pages = "${../firefox/homepage.html}";
        zoom.default = "100";

        content.blocking = {
          adblock.lists = [
            "https://easylist.to/easylist/easylist.txt"
            "https://easylist.to/easylist/easyprivacy.txt"
            "https://abpvn.com/filter/abpvn-iOCIg8.txt"
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
