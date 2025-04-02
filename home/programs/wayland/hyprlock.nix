{
  config,
  inputs,
  pkgs,
  ...
}: let
  font_family = "Maple Mono NF";
in {
  programs.hyprlock = {
    enable = true;

    package = inputs.hyprlock.packages.${pkgs.system}.hyprlock;

    settings = {
      general = {
        disable_loading_bar = true;
        immediate_render = true;
        hide_cursor = false;
        no_fade_in = true;
      };

      background = [
        {
          monitor = "";
          path = config.theme.wallpaper;
          blur_passes = 3;
          brightness = 0.817200;
          contrast = 0.891600;
          vibrancy = 0.169600;
        }
      ];

      input-field = [
        {
          monitor = "eDP-1";

          size = "300, 50";
          position = "0%, -5%";

          valign = "center";
          halign = "center";

          outline_thickness = 1;

          outer_color = "rgb(b6c4ff)";
          inner_color = "rgb(dce1ff)";
          font_color = "rgb(354479)";

          fade_on_empty = false;
          placeholder_text = ''<span font_family="${font_family}" foreground="##354479">Password...</span>'';

          dots_spacing = 0.2;
          dots_center = true;
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          inherit font_family;
          font_size = 150;
          color = "rgb(b6c4ff)";

          position = "0%, -20%";

          valign = "top";
          halign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:3600000] date +'%a, %b %d'";
          font_size = 30;
          color = "rgb(b6c4ff)";

          position = "0%, -18%";

          valign = "top";
          halign = "center";
        }
        {
          monitor = "";
          text = "Hi there, <span foreground='##86469C'><i>$USER</i></span> :)";
          inherit font_family;
          font_size = 30;
          color = "rgb(b6c4ff)";

          position = "0%, 0%";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
