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
        "caelestia-.*"
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
      "blurpopups, caelestia-.*"
      # "xray 1, ${toRegex ["caelestia-.*"]}"
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
      "workspace special:firefox, class:^(firefox)$"
      "workspace special:zen, class:^(zen.*)$"
      "workspace special:qutebrowser, class:^(.*qutebrowser.*)$"
      "workspace special:emacs, class:^(emacs)$"
      "workspace special:music, class:^(spotify)$"
      "size 1100 600, class:^(termfloat)$"
      "size 1100 600, class:^(thunar)$"

      "opacity 0.9, class:^(spotify)$"
      "xray 1, class:^(spotify)$"
      "opacity 0.99999, class:(zen.*)"
      "xray 1, class:(zen.*)"

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
      "idleinhibit focus, class:^(zen.*)$, title:^(.*YouTube.*)$"
      "idleinhibit fullscreen, class:^(zen.*)$"
      "idleinhibit always, class:^(discord)$"

      "dimaround, class:^(gcr-prompter)$"
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, class:^(polkit-gnome-authentication-agent-1)$"
      "dimaround, class:^(zen.*)$, title:^(File Upload)$"

      # fix xwayland apps
      "rounding 0, xwayland:1"
      "center, class:^(.*jetbrains.*)$, title:^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, class:^(.*jetbrains.*)$, title:^(splash)$"

      # don't render hyprbars on tiling windows
      "plugin:hyprbars:nobar, floating:0"

      # less sensitive scroll for some windows
      # browser(-based)
      "scrolltouchpad 0.1, class:^(zen.*|firefox|chromium-browser|chrome-.*)$"
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
