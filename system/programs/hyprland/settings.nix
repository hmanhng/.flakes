{
  self,
  config,
  pkgs,
  lib,
  ...
}:
let
  # pointer = config.home.pointerCursor;
  cursorName = "Bibata-Modern-Ice-Hyprcursor";
in
{
  programs.hyprland.settings = {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_QPA_PLATFORMTHEME,gtk3"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString 24}"
      # See https://github.com/hyprwm/contrib/issues/142
      "GRIMBLAST_NO_CURSOR,0"
    ];

    exec-once = [
      # finalize startup
      "uwsm finalize"
      # set cursor for HL itself
      "hyprctl setcursor ${cursorName} ${toString 24}"
      # "hyprlock"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

      "${lib.getExe' pkgs.wlsunset "wlsunset"} -t 5000 -S 7:00 -s 20:00"

      # clipboard
      "ydotoold"
      "wl-paste --watch cliphist store"
      "${lib.getExe pkgs.wl-clip-persist} --clipboard both"

      # run shell
      "caelestia resizer -d"
      "caelestia shell -d && caelestia shell lock lock"
    ];

    general = {
      gaps_in = 3;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" =
        "rgba(F38BA8FF) rgba(A6E3A1FF) rgba(F9E2AFFF) rgba(89B4FAFF) rgba(F5C2E7FF) rgba(94E2D5FF) 45deg";
      "col.inactive_border" = "rgba(00000088)";

      resize_on_border = true;
    };

    decoration = {
      rounding = 10;
      rounding_power = 2.5;
      # active_opacity = 1;
      # inactive_opacity = 0.8;
      # dim_inactive = true;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.01;

        vibrancy = 0.2;
        vibrancy_darkness = 0.5;

        passes = 3;
        size = 7;
      };

      shadow = {
        enabled = false;
        color = "rgba(00000055)";
        ignore_window = true;
        offset = "0 15";
        range = 100;
        render_power = 2;
        scale = 0.97;
      };
    };

    animations.enabled = true;

    bezier = [
      "fluent_decel, 0, 0.2, 0.4, 1"
      "easeOutCirc, 0, 0.55, 0.45, 1"
      "easeOutCubic, 0.33, 1, 0.68, 1"
      "fade_curve, 0, 0.55, 0.45, 1"
    ];
    animation = [
      # name, enable, speed, curve, style

      # Windows
      "windowsIn,   0, 4, easeOutCubic,  popin 20%" # window open
      "windowsOut,  0, 4, fluent_decel,  popin 80%" # window close.
      "windowsMove, 1, 2, fluent_decel, slide" # everything in between, moving, dragging, resizing.

      # Fade
      "fadeIn,      1, 3,   fade_curve" # fade in (open) -> layers and windows
      "fadeOut,     1, 3,   fade_curve" # fade out (close) -> layers and windows
      "fadeSwitch,  0, 1,   easeOutCirc" # fade on changing activewindow and its opacity
      "fadeShadow,  1, 10,  easeOutCirc" # fade on changing activewindow for shadows
      "fadeDim,     1, 4,   fluent_decel" # the easing of the dimming of inactive windows
      # "border,      1, 2.7, easeOutCirc"  # for animating the border's color switch speed
      # "borderangle, 1, 30,  fluent_decel, once" # for animating the border's gradient angle - styles: once (default), loop
      "workspaces,  1, 4,   easeOutCubic, fade" # styles: slide, slidevert, fade, slidefade, slidefadevert
    ];

    input = {
      kb_layout = "us";

      follow_mouse = 1; # 0|1|2|3
      accel_profile = "flat";
      tablet.output = "current";
    };

    # touchpad gestures
    gestures = {
      workspace_swipe_forever = true;
    };

    gesture = [
      "3, horizontal, workspace"
      "4, left, dispatcher, movewindow, mon:-1"
      "4, right, dispatcher, movewindow, mon:+1"
      "4, pinch, fullscreen"
    ];

    group = {
      groupbar = {
        font_size = 10;
        gradients = false;
        text_color = "rgb(b6c4ff)";
      };
      "col.border_active" = "rgba(35447988)";
      "col.border_inactive" = "rgba(dce1ff88)";
    };

    dwindle = {
      # keep floating dimentions while tiling
      pseudotile = true;
      preserve_split = true;
    };

    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      force_default_wallpaper = 0;

      # disable dragging animation
      animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;

      # focus_on_activate = true;

      on_focus_under_fullscreen = 0;

      # enable_swallow = true;
      swallow_regex = "foot";
      swallow_exception_regex = "";
    };

    render.direct_scanout = 2;

    xwayland.force_zero_scaling = true;

    debug.disable_logs = false;

    ecosystem = {
      no_update_news = true;
      no_donation_nag = true;
    };
  };
}
