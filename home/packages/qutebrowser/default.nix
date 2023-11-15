{
  xdg.configFile."qutebrowser/userscripts/translate".source = ./translate;
  programs = {
    qutebrowser = {
      enable = true;
      quickmarks = {};
      extraConfig = ''
        # vim:fileencoding=utf-8:foldmethod=marker
        # from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401,E501 pylint: disable=unused-import
        # from qutebrowser.config.config import ConfigContainer  # noqa: F401,E501 pylint: disable=unused-import
        # config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
        # c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103
        # config.load_autoconfig()
        c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}
        # ============================== AdBlocks ============================== {{{
        c.content.blocking.adblock.lists = [
          "https://easylist.to/easylist/easylist.txt",
          "https://easylist.to/easylist/easyprivacy.txt",
          "https://abpvn.com/filter/abpvn-iOCIg8.txt"
        ]
        c.content.blocking.hosts.lists = [
          "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
        ]
        c.content.blocking.method = 'both'
        # }}}
        # ============================== Colors ============================== {{{
        import os
        from urllib.request import urlopen

        if not os.path.exists(config.configdir / "theme.py"):
          theme = "https://raw.githubusercontent.com/catppuccin/qutebrowser/main/setup.py"
          with urlopen(theme) as themehtml:
            with open(config.configdir / "theme.py", "a") as file:
              file.writelines(themehtml.read().decode("utf-8"))

        if os.path.exists(config.configdir / "theme.py"):
          import theme
          theme.setup(c, 'macchiato', True)
        # }}}
        # ============================== Fonts ============================== {{{
        c.fonts.default_family = 'Iosevka Nerd Font'
        c.fonts.default_size = '15pt'
        c.fonts.completion.entry = 'default_size default_family'
        c.fonts.debug_console = 'default_size default_family'
        c.fonts.prompts = 'default_size sans-serif'
        c.fonts.statusbar = 'default_size default_family'
        # }}}
        # ============================== Bind ============================== {{{
        config.bind('.', 'cmd-set-text :')
        config.bind(',D', 'hint links spawn kitty yt-dlp {hint-url}')
        config.bind(',d', 'hint links spawn xdman {hint-url}')
        config.bind(',m', 'hint links spawn mpv --profile=M60 {hint-url}')
        config.bind(',p', 'set content.proxy http://localhost:8080/')
        config.bind(',P', 'set content.proxy system')
        config.bind('ch', 'history-clear')
        config.bind('t', 'cmd-set-text -s :open -t')
        config.bind('wr', 'config-source')
        config.bind('ww', 'config-write-py -f')
        config.bind('xb', 'config-cycle statusbar.show always never')
        config.bind('xt', 'config-cycle tabs.show always never')
        config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
        config.bind(';t', 'hint userscript link translate')
        config.bind(';T', 'hint userscript all translate --text')
        config.bind(',t', 'spawn --userscript translate')
        config.bind(',T', 'spawn --userscript translate --text')
        config.bind('<Ctrl+r>', 'restart')
        # }}}
        # ============================== SOME ELSE ============================== {{{
        c.downloads.location.directory = '~/Downloads'
        c.editor.command = ['kitty', 'nvim', '{file}']
        c.statusbar.show = 'always'
        c.tabs.show = 'always'
        c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?q={}', 'aw': 'https://wiki.archlinux.org/?search={}', 're': 'https://www.reddit.com/r/{}', 'ub': 'https://www.urbandictionary.com/define.php?term={}', 'wiki': 'https://en.wikipedia.org/wiki/{}', 'yt': 'https://www.youtube.com/results?search_query={}', 'np': 'https://search.nixos.org/packages?channel=unstable&query={}', 'no': 'https://search.nixos.org/options?channel=unstable&query={}'}
        c.url.default_page = '${../firefox/homepage.html}'
        c.url.start_pages = '${../firefox/homepage.html}'
        c.zoom.default = '100'
        # }}}
      '';
    };
  };
}
