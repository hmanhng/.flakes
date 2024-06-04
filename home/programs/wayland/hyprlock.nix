{config, ...}: let
  variant = "dark";
  c = config.programs.matugen.theme.colors.colors.${variant};

  font_family = "Maple Mono";
in {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
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

          size = "350, 50";

          outline_thickness = 1;

          outer_color = "rgb(${c.primary})";
          inner_color = "rgb(${c.on_primary_container})";
          font_color = "rgb(${c.primary_container})";

          fade_on_empty = false;
          placeholder_text = ''<span font_family="${font_family}" foreground="##${c.primary_container}">Password...</span>'';

          dots_spacing = 0.2;
          dots_center = true;
          valign = "center";
          halign = "center";
          position = "0, -120";
        }
      ];

      label = [
        {
          monitor = "";
          text = "$TIME";
          inherit font_family;
          font_size = 150;
          color = "rgb(${c.primary})";

          position = "0, -300";

          valign = "top";
          halign = "center";
        }
        {
          monitor = "";
          text = "Hi <span foreground='##86469C'><i>$USER</i></span> :)";
          inherit font_family;
          font_size = 30;
          color = "rgb(${c.primary})";

          position = "0, -40";

          valign = "center";
          halign = "center";
        }
      ];
    };
  };
}
