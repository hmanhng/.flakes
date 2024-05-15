{
  self,
  # config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    env = [
      "QT_SCALE_FACTOR,1.25"
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "QT_AUTO_SCREEN_SCALE_FACTOR,1"
    ];

    exec-once = [
      "launch_waybar"
      "${lib.getExe pkgs.networkmanagerapplet}"
      "${lib.getExe' pkgs.wlsunset "wlsunset"} -t 5000 -S 7:00 -s 20:00"
      # "border_color"
      "ydotoold"
      "wl-paste --watch cliphist store"
      "${lib.getExe pkgs.wl-clip-persist} --clipboard both"
      "${lib.getExe self.legacyPackages.${pkgs.system}.spoof-dpi}"
      "MINEMACS_ALPHA=90 emacs --daemon"
    ];

    monitor = [", preferred, auto, 1"];

    general = {
      gaps_in = 3;
      gaps_out = 5;
      border_size = 2;
      "col.active_border" = "rgba(F38BA8FF) rgba(A6E3A1FF) rgba(F9E2AFFF) rgba(89B4FAFF) rgba(F5C2E7FF) rgba(94E2D5FF) 45deg";
      "col.inactive_border" = "rgba(00000088)";

      resize_on_border = true;
    };

    decoration = {
      rounding = 10;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;

        size = 10;
        passes = 3;
      };

      drop_shadow = true;
      shadow_ignore_window = true;
      shadow_offset = "0 2";
      shadow_range = 20;
      shadow_render_power = 3;
      "col.shadow" = "rgba(00000055)";
    };

    animations = {
      enabled = true;
      animation = [
        "border, 1, 2, default"
        "fade, 1, 4, default"
        "windows, 1, 3, default, popin 80%"
        "workspaces, 1, 2, default, slide"
      ];
    };

    input = {
      kb_layout = "us";

      follow_mouse = 1; # 0|1|2|3
      touchpad = {
        natural_scroll = true;
      };
      sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
    };

    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      force_default_wallpaper = 0;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;

      # we do, in fact, want direct scanout
      no_direct_scanout = false;

      # focus_on_activate = true;

      # enable_swallow = true;
      swallow_regex = "kitty";
      swallow_exception_regex = "";
    };

    xwayland = {force_zero_scaling = true;};

    dwindle = {
      no_gaps_when_only = false;
      pseudotile = true;
      preserve_split = true;
    };

    master = {
      special_scale_factor = 0.8;
      new_is_master = true;
      no_gaps_when_only = false;
    };
  };
}
