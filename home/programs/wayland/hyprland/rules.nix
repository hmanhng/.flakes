{
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "animation slide right, class:^(kitty)$"
      "center 1, class:^(firefox)$,floating:1"
      "workspace name:Firefox, class:^(firefox)$"
      "workspace name:Emacs, class:^(emacs)$"
      "opacity 0.80 0.80, title:^(Spotify)"
      "workspace name:Music, title:^(Spotify)"
      "center 1, class:^(termfloat)$"
      "size 1100 600, class:^(termfloat)$"
      "size 1100 600, class:^(thunar)$"

      "float, title:^(Picture-in-Picture)$"
      "float, class:^(imv)$"
      "float, class:^(mpv)$"
      "float, class:^(termfloat)$"
      "float, class:^(thunar)$"
      "float, class:^(pavucontrol)$"
      "float, class:^(ncmpcpp)"
      "float, class:^(confirm)$"
      "float, class:^(dialog)$"
      "float, class:^(download)$"
      "float, class:^(notification)$"
      "float, class:^(error)$"
      "float, class:^(confirmreset)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|celluloid)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"
      "noshadow,class:^(xwaylandvideobridge)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"
    ];
  };
}
