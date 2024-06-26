{
  lib,
  pkgs,
  ...
}: let
  cava-internal = pkgs.writeShellScriptBin "cava-internal" ''
    cava -p ~/.config/cava/config1 | sed -u 's/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
  '';
  grimblast_watermark = pkgs.writeShellScriptBin "grimblast_watermark" ''
        FILE=$(date "+%Y-%m-%d"T"%H:%M:%S").png
    # Get the picture from maim
        grimblast --notify --cursor save area $XDG_SCREENSHOTS_DIR/src.png >> /dev/null 2>&1
    # add shadow, round corner, border and watermark
        convert $XDG_SCREENSHOTS_DIR/src.png \
          \( +clone -alpha extract \
          -draw 'fill black polygon 0,0 0,8 8,0 fill white circle 8,8 8,0' \
          \( +clone -flip \) -compose Multiply -composite \
          \( +clone -flop \) -compose Multiply -composite \
          \) -alpha off -compose CopyOpacity -composite $XDG_SCREENSHOTS_DIR/output.png
    #
        convert $XDG_SCREENSHOTS_DIR/output.png -bordercolor none -border 20 \( +clone -background black -shadow 80x8+15+15 \) \
          +swap -background transparent -layers merge +repage $XDG_SCREENSHOTS_DIR/$FILE
    #
        composite -gravity Southeast "${./watermark.png}" $XDG_SCREENSHOTS_DIR/$FILE $XDG_SCREENSHOTS_DIR/$FILE
    #
        wl-copy < $XDG_SCREENSHOTS_DIR/$FILE
    #   remove the other pictures
        rm $XDG_SCREENSHOTS_DIR/src.png $XDG_SCREENSHOTS_DIR/output.png
  '';
  # myswaylock = pkgs.writeShellScriptBin "myswaylock" ''
  #   ${pkgs.swaylock-effects}/bin/swaylock \
  #          --screenshots \
  #          --clock \
  #          --indicator \
  #          --indicator-radius 100 \
  #          --indicator-thickness 7 \
  #          --effect-blur 7x5 \
  #          --effect-vignette 0.5:0.5 \
  #          --ring-color 3b4252 \
  #          --key-hl-color 880033 \
  #          --line-color 00000000 \
  #          --inside-color 00000088 \
  #          --separator-color 00000000 \
  #          --grace 2 \
  #          --fade-in 0.3
  # '';
  # wallpaper_random = pkgs.writeShellScriptBin "wallpaper_random" ''
  #   killall dynamic_wallpaper
  #   ${lib.getExe pkgs.swww} img $(find ~/Pictures/wallpapers/. -iregex '.*\.\(jpg\|jpeg\|png\|gif\|bmp\)' | shuf -n1) --transition-type random
  # '';
  # dynamic_wallpaper = pkgs.writeShellScriptBin "dynamic_wallpaper" ''
  #   ${lib.getExe pkgs.swww} img $(find ~/Pictures/wallpapers/. -iregex '.*\.\(jpg\|jpeg\|png\|gif\|bmp\)' | shuf -n1) --transition-type random
  #   OLD_PID=$!
  #   while true; do
  #     sleep 120
  #     ${lib.getExe pkgs.swww} img $(find ~/Pictures/wallpapers/. -iregex '.*\.\(jpg\|jpeg\|png\|gif\|bmp\)' | shuf -n1)
  #     NEXT_PID=$!
  #     sleep 5
  #     kill $OLD_PID
  #     OLD_PID=$NEXT_PID
  #   done
  # '';
  # default_wall = pkgs.writeShellScriptBin "default_wall" ''
  #   killall dynamic_wallpaper
  #   ${lib.getExe pkgs.swww} img ${wallpaper} --transition-type random
  # '';
  launch_waybar = pkgs.writeShellScriptBin "launch_waybar" ''
    #!/usr/bin/env bash
    killall .waybar-wrapped
    SDIR="$HOME/.config/waybar"
    waybar -c "$SDIR"/config -s "$SDIR"/style.css > /dev/null 2>&1 &
  '';
  border_color = pkgs.writeShellScriptBin "border_color" ''
      function border_color {
      if [[ "$GTK_THEME" == "Catppuccin-Frappe-Pink" ]]; then
        hyprctl keyword general:col.active_border rgb\(ffc0cb\)
      elif [[ "$GTK_THEME" == "Catppuccin-Latte-Green" ]]; then
          hyprctl keyword general:col.active_border rgb\(C4ACEB\)
      else
          hyprctl keyword general:col.active_border rgb\(81a1c1\)
      fi
    }

    socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | while read line; do border_color $line; done
  '';
in {
  home.packages = with pkgs; [
    # cava-internal
    # wallpaper_random
    grimblast_watermark
    # myswaylock
    # dynamic_wallpaper
    # default_wall
    launch_waybar
    # border_color
  ];
}
