{config, ...}: let
  colors = {
    dark = {
      foreground = "bbc2cf"; # Text
      background = "282c34"; # Base
      regular0 = "1c1f24"; # Surface 1
      regular1 = "ff6c6b"; # red
      regular2 = "98be65"; # green
      regular3 = "da8548"; # yellow
      regular4 = "48a7e7"; # blue
      regular5 = "c678dd"; # maroon
      regular6 = "5699af"; # teal
      regular7 = "abb2bf"; # Subtext 1
      bright0 = "5b6268"; # Surface 2
      bright1 = "da8548"; # red
      bright2 = "4db5bd"; # green
      bright3 = "ecbe7b"; # yellow
      bright4 = "3071db"; # blue
      bright5 = "a9a1e1"; # maroon
      bright6 = "46d9ff"; # teal
      bright7 = "dfdfdf"; # Subtext 0
      selection-foreground = "bbc2cf";
      selection-background = "3e4451";
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
        # term = "xterm-256color"; # default: foot
        font = "Maple Mono:size=15";
        box-drawings-uses-font-glyphs = "yes";
        pad = "5x0 center";
        notify = "notify-send -a \${app-id} -i \${app-id} \${title} \${body}";
        selection-target = "clipboard";
        bold-text-in-bright = "palette-based";
      };

      scrollback = {
        lines = 10000;
        multiplier = 3; # default 3
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
