{
  self,
  # config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    env = ''
      GDK_BACKEND,wayland
    '';
    exec-once = [
      "launch_waybar"
      "${lib.getExe pkgs.networkmanagerapplet}"
      "${lib.getExe' pkgs.wlsunset "wlsunset"} -t 5000 -S 7:00 -s 20:00"
      # "border_color"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "${lib.getExe self.legacyPackages.${pkgs.system}.spoof-dpi}"
      "ydotoold"
      "${lib.getExe pkgs.wl-clip-persist} --clipboard both"
      "MINEMACS_ALPHA=90 emacs --daemon"
    ];
    xwayland = {force_zero_scaling = true;};
    input = {
      kb_layout = "us";
      follow_mouse = 2; # 0|1|2|3
      float_switch_override_focus = 2;
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
      vfr = true;
      disable_autoreload = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      focus_on_activate = true;
      # enable_swallow = true;
      swallow_regex = "kitty";
      swallow_exception_regex = "";
    };
    general = {
      monitor = [", preferred, auto, 1"];
      gaps_in = 3;
      gaps_out = 5;
      border_size = 3;
      "col.active_border" = "rgba(F38BA8FF) rgba(A6E3A1FF) rgba(F9E2AFFF) rgba(89B4FAFF) rgba(F5C2E7FF) rgba(94E2D5FF) 45deg";
      "col.inactive_border" = false;
      no_border_on_floating = false;
      layout = "dwindle"; # master|dwindle
    };
    decoration = {
      rounding = 0;
      blur = {
        enabled = true;
        size = 5;
        passes = 3;
        new_optimizations = true;
        xray = true;
        ignore_opacity = true;
        noise = "0.1";
        contrast = "1.1";
        brightness = "1.2";
      };
      blurls = ["waybar" "lockscreen"];
    };
    animations = {
      bezier = [
        "overshot, 0.05, 0.9, 0.1, 1.05"
        # bezier = overshot, 0.13, 0.99, 0.29, 1.1
        "smoothOut, 0.36, 0, 0.66, -0.56"
        "smoothIn, 0.25, 1, 0.5, 1"
      ];

      # animation list
      animation = [
        "windows, 1, 5, overshot, slide"
        "windowsOut, 1, 4, smoothOut, slide"
        "windowsMove, 1, 4, default"
        "border, 1, 10, default"
        "fade, 1, 10, smoothIn"
        "fadeDim, 1, 10, smoothIn"
        "workspaces, 1, 6, overshot, slidevert"
      ];
    };
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
