{lib, ...}: {
  programs.hyprland.settings = {
    # layer rules
    layerrule = let
      toRegex = list: let
        elements = lib.concatStringsSep "|" list;
      in "^(${elements})$";
      lowopacity = [
        "waybar"
        "calendar"
        "notifications"
        "system-menu"
      ];
      highopacity = [
        "anyrun"
        "osd"
        "logout_dialog"
      ];
      blurred = lib.concatLists [
        lowopacity
        highopacity
      ];
    in [
      "blur, ${toRegex blurred}"
      "xray 1, ${toRegex ["waybar"]}"
      "ignorealpha 0.5, ${toRegex (highopacity ++ ["music"])}"
      "ignorealpha 0.2, ${toRegex lowopacity}"
    ];

    # window rules
    windowrulev2 = [
      # Bitwarden extension
      "float, title:^(.*Bitwarden Password Manager.*)$"
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

      # workspace
      "workspace name:Firefox, class:^(firefox)$"
      "workspace name:Zen, class:^(zen)$"
      "workspace name:Emacs, class:^(emacs)$"
      "workspace name:Music, title:^(Spotify.*)$"
      "workspace name:Music, class:^(tidal-hifi)$"
      "size 1100 600, class:^(termfloat)$"
      "size 1100 600, class:^(thunar)$"

      "opacity 0.9, class:^(tidal-hifi)$"

      # make Firefox/Zen PiP window floating and sticky
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, title:^(Firefox — Sharing Indicator)$"
      "workspace special silent, title:^(Zen — Sharing Indicator)$"
      "workspace special silent, title:^(.*is sharing (your screen|a window)\.)$"

      # idle inhibit while watching videos
      "idleinhibit focus, class:^(mpv|.+exe|vlc)$"
      "idleinhibit focus, class:^(firefox)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(firefox)$"
      "idleinhibit focus, class:^(zen)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(zen)$"
      "idleinhibit always, class:^(discord)$"

      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
      "dimaround, class:^(zen)$, title:^(File Upload)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"

      # don't render hyprbars on tiling windows
      "plugin:hyprbars:nobar, floating:0"

      # less sensitive scroll for some windows
      # browser(-based)
      "scrolltouchpad 0.1, class:^(zen|firefox|chromium-browser|chrome-.*)$"
      "scrolltouchpad 0.1, class:^(obsidian)$"
      # GTK3
      "scrolltouchpad 0.1, class:^(com.github.xournalpp.xournalpp)$"
      "scrolltouchpad 0.1, class:^(libreoffice.*)$"
      "scrolltouchpad 0.1, class:^(.virt-manager-wrapped)$"
      "scrolltouchpad 0.1, class:^(xdg-desktop-portal-gtk)$"
      # Qt5
      "scrolltouchpad 0.1, class:^(org.prismlauncher.PrismLauncher)$"
      "scrolltouchpad 0.1, class:^(org.kde.kdeconnect.app)$"
      # Others
      "scrolltouchpad 0.1, class:^(org.pwmt.zathura)$"
    ];
  };
}
