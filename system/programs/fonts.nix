{
  pkgs,
  self,
  ...
}: let
  myFont = builtins.fetchTarball {
    url = "https://github.com/hmanhng/fonts/archive/master.tar.gz";
    sha256 = "02ifsl1rvigslxdlrfm54d8lgx14i70zc0w6r3k1izzh13m76ggg";
  };
in {
  home-manager.users.hmanhng = {
    xdg.dataFile."./fonts" = {
      source = "${myFont}";
      recursive = true;
    };
    home.packages = with pkgs; [font-manager];
  };

  fonts = {
    packages =
      (with pkgs; [
        # lexend
        # corefonts
        # roboto
        # roboto-serif
        # noto-fonts
        nerd-fonts.iosevka

        maple-mono.NF
        ibm-plex

        noto-fonts-emoji
        twemoji-color-font
      ])
      ++ (with self.legacyPackages.${pkgs.system}; [
        # apple-fonts
      ]);

    enableDefaultPackages = false;

    fontconfig = {
      defaultFonts = {
        serif = ["IBM Plex Serif"];
        sansSerif = ["IBM Plex Sans"];
        monospace = ["IBM Plex Mono"];
      };
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>

          <match target="scan">
              <test name="family">
                  <string>Liga CodeNewRoman Nerd Font</string>
              </test>
              <edit name="spacing">
                  <int>100</int>
              </edit>
          </match>

        </fontconfig>
      '';
    };
  };
}
