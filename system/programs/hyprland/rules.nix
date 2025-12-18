{ lib, ... }:
{
  programs.hyprland.settings = {
    # layer rules
    layerrule =
      let
        toRegex =
          list:
          let
            elements = lib.concatStringsSep "|" list;
          in
          "match:namespace ^(${elements})$";
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
      in
      [
        "blur on, ${toRegex blurred}"
        "blur_popups on, match:namespace caelestia-.*"
        # "xray 1, ${toRegex ["caelestia-.*"]}"
        "ignore_alpha 0.5, ${toRegex (highopacity ++ [ "music" ])}"
        "ignore_alpha 0.2, ${toRegex lowopacity}"
      ];

    # window rules
    windowrule = [
      # Bitwarden extension
      "float on, match:title ^(.*Bitwarden Password Manager.*)$"
      # telegram media viewer
      "float on, match:title ^(Media viewer)$"

      "float on, match:class ^(imv)$"
      "float on, match:class ^(mpv)$"
      "float on, match:class ^(termfloat)$"
      "float on, match:class ^(thunar)$"
      "float on, match:class ^(com.saivert.pwvucontrol)$"
      "float on, match:class ^(ncmpcpp)"
      "float on, match:class ^(confirm)$"
      "float on, match:class ^(dialog)$"
      "float on, match:class ^(download)$"
      "float on, match:class ^(notification)$"
      "float on, match:class ^(error)$"
      "float on, match:class ^(confirmreset)$"

      # workspace
      "workspace special:firefox, match:class ^(firefox)$"
      "workspace special:zen, match:class ^(zen.*)$"
      "workspace special:qutebrowser, match:class ^(.*qutebrowser.*)$"
      "workspace special:emacs, match:class ^(emacs)$"
      "workspace special:music, match:class ^(spotify)$"
      "size 1100 600, match:class ^(termfloat)$"
      "size 1100 600, match:class ^(thunar)$"

      "opacity 0.9, match:class ^(spotify)$"
      "xray 1, match:class ^(spotify)$"
      "opacity 0.99999, match:class (zen.*)"
      "xray 1, match:class (zen.*)"

      # make Firefox/Zen PiP window floating and sticky
      "float on, match:title ^(Picture-in-Picture)$"
      "pin on, match:title ^(Picture-in-Picture)$"
      "no_dim on, match:title ^(Picture-in-Picture)$"

      # throw sharing indicators away
      "workspace special silent, match:title ^(Zen — Sharing Indicator)$"
      "workspace special silent, match:title ^(.*is sharing (your screen|a window)\.)$"

      # idle inhibit while watching videos
      "idle_inhibit focus, match:class ^(mpv|.+exe|vlc)$"
      "idle_inhibit focus, match:class ^(zen.*)$, match:title ^(.*YouTube.*)$"
      "idle_inhibit fullscreen, match:class ^(zen.*)$"
      "idle_inhibit always, match:class ^(discord)$"

      "dim_around on, match:class ^(gcr-prompter)$"
      "dim_around on, match:class ^(xdg-desktop-portal-gtk)$"
      "dim_around on, match:class ^(polkit-gnome-authentication-agent-1)$"
      "dim_around on, match:class ^(zen.*)$, match:title ^(File Upload)$"

      # fix xwayland apps
      "rounding 0, match:xwayland true"
      "center on, match:class ^(.*jetbrains.*)$, match:title ^(Confirm Exit|Open Project|win424|win201|splash)$"
      "size 640 400, match:class ^(.*jetbrains.*)$, match:title ^(splash)$"

      # less sensitive scroll for some windows
      # browser(-based)
      "scroll_touchpad 0.1, match:class ^(zen.*|firefox)$"
      # Others
      # "scroll_touchpad 0.1, match:class ^(org.pwmt.zathura)$"
    ];
  };
}
