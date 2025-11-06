{
  pkgs,
  lib,
  ...
}: let
  colors = {
    dark = {
      foreground = "e5e1e7"; # Text (onBackground)
      background = "141317"; # Base

      regular0 = "262529"; # Surface 0
      regular1 = "c6a4fb"; # red
      regular2 = "c8e3ff"; # green
      regular3 = "ffecf3"; # yellow
      regular4 = "b5b6ff"; # blue
      regular5 = "ccb4eb"; # maroon
      regular6 = "d5dfff"; # teal
      regular7 = "c9c5d0"; # Subtext 1

      bright0 = "38373c"; # Surface 1
      bright1 = "c791ff"; # bright red
      bright2 = "89ecff"; # bright green
      bright3 = "fff0f6"; # bright yellow
      bright4 = "9ca9d8"; # bright blue
      bright5 = "cdb4f3"; # bright maroon
      bright6 = "bae0ff"; # bright teal
      bright7 = "ffffff"; # Subtext 0

      selection-foreground = "e5e1e7"; # text color on selection
      selection-background = "47454f"; # selection background
    };

    light = {
      foreground = "4c4f69"; # Text
      background = "eff1f5"; # Base
      regular0 = "bcc0cc"; # Surface 1
      regular1 = "d20f39"; # red
      regular2 = "40a02b"; # green
      regular3 = "df8e1d"; # yellow
      regular4 = "1e66f5"; # blue
      regular5 = "e64553"; # maroon
      regular6 = "179299"; # teal
      regular7 = "5c5f77"; # Subtext 1
      bright0 = "acb0be"; # Surface 2
      bright1 = "d20f39"; # red
      bright2 = "40a02b"; # green
      bright3 = "df8e1d"; # yellow
      bright4 = "1e66f5"; # blue
      bright5 = "e64553"; # maroon
      bright6 = "179299"; # teal
      bright7 = "6c6f85"; # Subtext 0
    };
  };
in {
  programs.foot = {
    enable = true;

    settings = {
      main = {
        font = "Maple Mono NF:size=15";
        box-drawings-uses-font-glyphs = "yes";
        horizontal-letter-offset = 0;
        vertical-letter-offset = 0;
        pad = "5x0 center";
        selection-target = "clipboard";
        bold-text-in-bright = "palette-based";
      };

      bell = {
        urgent = "yes";
        notify = "yes";
      };

      desktop-notifications = {
        command = "${lib.getExe pkgs.libnotify} -a \${app-id} -i \${app-id} \${title} \${body}";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3; # default 3
        indicator-position = "relative";
        indicator-format = "line";
      };

      url = {
        launch = "${pkgs.xdg-utils}/bin/xdg-open \${url}";
      };

      cursor = {
        style = "beam";
        blink = "yes";
        beam-thickness = 1.5; # default 1.5
      };

      mouse = {
        hide-when-typing = "yes";
      };

      colors =
        {
          alpha = 0.9;
        }
        // colors.dark;
    };
  };
}
