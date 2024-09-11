{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "^(${elements})$";

      ignorealpha = [
        # ags
        "calendar"
        "notifications"
        "osd"
        "system-menu"

        "rofi"
        "logout_dialog"
      ];

      layers = ignorealpha ++ ["waybar"];
    in [
      "blur, ${toRegex layers}"
      "xray 1, ${toRegex ["waybar"]}"
      "ignorealpha 0.2, ${toRegex ["waybar" "logout_dialog"]}"
      "ignorealpha 0.5, ${toRegex (ignorealpha ++ ["music"])}"
    ];

    # window rules
    windowrulev2 = [
      "workspace name:Firefox, class:^(firefox)$"
      "workspace name:Emacs, class:^(emacs)$"
      "workspace name:Music, title:^(Spotify.*)$"
      "workspace name:Music, class:^(tidal-hifi)$"
      "size 1100 600, class:^(termfloat)$"
      "size 1100 600, class:^(thunar)$"

      "opacity 0.9, class:^(tidal-hifi)$"

      # make Firefox PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # telegram media viewer
      "float, title:^(Media viewer)$"
      "float, class:^(imv)$"
      "float, class:^(mpv)$"
      "float, class:^(termfloat)$"
      "float, class:^(thunar)$"
      "float, class:^(com.saivert.pwvucontrol)$"
      "float, class:^(ncmpcpp)"
      "float, class:^(confirm)$"
      "float, class:^(dialog)$"
      "float, class:^(download)$"
      "float, class:^(notification)$"
      "float, class:^(error)$"
      "float, class:^(confirmreset)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|vlc)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"
      "idleinhibit always, class:^(discord)$"

      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"
    ];
  };
}
