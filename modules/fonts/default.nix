{ config, lib, pkgs, user, ... }:
let
  myFont = builtins.fetchTarball {
    url = "https://github.com/hmanhng/fonts/archive/master.tar.gz";
    sha256 = "02ifsl1rvigslxdlrfm54d8lgx14i70zc0w6r3k1izzh13m76ggg";
  };
in
{
  home-manager.users.${user} = {
    xdg.dataFile."./fonts" = { source = "${myFont}"; recursive = true; };
  };

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      # noto-fonts-emoji
      # nerdfonts
      # (nerdfonts.override {
      #   fonts = [
      # "Iosevka"
      # "JetBrainsMono"
      # "CodeNewRoman"
      # ];
      # })
      # font-awesome
    ];
    fontconfig = {
      localConf = ''
        <?xml version="1.0"?>
        <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
        <fontconfig>
          <!-- Default system-ui fonts -->
          <match target="pattern">
            <test name="family">
              <string>system-ui</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>sans-serif</string>
            </edit>
          </match>

          <!-- Default sans-serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>sans-serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans CJK SC</string>
              <string>Noto Sans</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <!-- Default serif fonts-->
          <match target="pattern">
            <test name="family">
              <string>serif</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif CJK SC</string>
              <string>Noto Serif</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <!-- Default monospace fonts-->
          <match target="pattern">
            <test name="family">
              <string>monospace</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans Mono CJK SC</string>
              <string>Symbols Nerd Font</string>
              <string>Twemoji</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK HK</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <!-- not have HK -->
              <string>Noto Serif CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-HK</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK HK</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>zh-TW</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK TC</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
                <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ja</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK JP</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Sans CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans CJK KR</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Serif CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Serif CJK KR</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang">
              <string>ko</string>
            </test>
            <test name="family">
              <string>Noto Sans Mono CJK SC</string>
            </test>
            <edit name="family" binding="strong">
              <string>Noto Sans Mono CJK KR</string>
            </edit>
          </match>

          <!-- Replace monospace fonts -->
          <match target="pattern">
            <test name="family" compare="contains">
              <string>Source Code</string>
            </test>
            <edit name="family" binding="strong">
              <string>Iosevka Term</string>
            </edit>
          </match>
          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Noto Sans CJK</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Sans</string>
            </edit>
          </match>

          <match target="pattern">
            <test name="lang" compare="contains">
              <string>en</string>
            </test>
            <test name="family" compare="contains">
              <string>Noto Serif CJK</string>
            </test>
            <edit name="family" mode="prepend" binding="strong">
              <string>Noto Serif</string>
            </edit>
          </match>

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
