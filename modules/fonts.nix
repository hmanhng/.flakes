{
  pkgs,
  user,
  self,
  ...
}: let
  myFont = builtins.fetchTarball {
    url = "https://github.com/hmanhng/fonts/archive/master.tar.gz";
    sha256 = "02ifsl1rvigslxdlrfm54d8lgx14i70zc0w6r3k1izzh13m76ggg";
  };
in {
  home-manager.users.${user} = {
    xdg.dataFile."./fonts" = {
      source = "${myFont}";
      recursive = true;
    };
  };

  fonts = {
    packages =
      (with pkgs; [
        lexend
        corefonts
        roboto
        roboto-serif
        # noto-fonts
        maple-mono

        noto-fonts-emoji
        twemoji-color-font
      ])
      ++ (with self.legacyPackages.${pkgs.system}; [
        apple-fonts
      ]);
    fontconfig = {
      defaultFonts = {
        serif = ["SF Pro Display"];
        sansSerif = ["SF Pro Display"];
        monospace = ["JetBrainsMono Nerd Font"];
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
