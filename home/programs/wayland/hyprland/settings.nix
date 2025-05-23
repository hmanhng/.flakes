{
  self,
  config,
  pkgs,
  lib,
  ...
}: let
  pointer = config.home.pointerCursor;

  cursorName = "Bibata-Modern-Ice-Hyprcursor";
in {
  wayland.windowManager.hyprland.settings = {
    env = [
      "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      "HYPRCURSOR_THEME,${cursorName}"
      "HYPRCURSOR_SIZE,${toString pointer.size}"
    ];

    exec-once = [
      # finalize startup
      "uwsm finalize"
      # set cursor for HL itself
      "hyprctl setcursor ${cursorName} ${toString pointer.size}"
      "hyprlock"

      "launch_waybar"
      "${lib.getExe pkgs.networkmanagerapplet}"
      "${lib.getExe' pkgs.wlsunset "wlsunset"} -t 5000 -S 7:00 -s 20:00"
      # "border_color"
      "ydotoold"
      "wl-paste --watch cliphist store"
      "${lib.getExe pkgs.wl-clip-persist} --clipboard both"
      "${lib.getExe self.legacyPackages.${pkgs.system}.spoofdpi}"
      "emacs --daemon"
    ];

    monitor = [
      "desc:Lenovo Group Limited 0x8AAF, 3072x1920@60, 0x0, 2" # thinkbook 14 g6+ 14.5inh 3k 120hz
      # "desc:AU Optronics 0x353D, preferred, 0x0, 1.2" # old ideapad 14inh
      "desc:Samsung Electric Company LF24T450F HNAX500305, 1920x1080@75, auto-right, 1" # samsung 24inh
    ];

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
      rounding_power = 3;
      blur = {
        enabled = true;
        brightness = 1.0;
        contrast = 1.0;
        noise = 0.02;

        size = 10;
        passes = 3;
      };

      shadow = {
        enabled = true;
        color = "rgba(00000055)";
        ignore_window = true;
        offset = "0 15";
        range = 100;
        render_power = 2;
        scale = 0.97;
      };
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
      workspace_swipe_forever = true;
    };

    misc = {
      disable_autoreload = true;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;

      force_default_wallpaper = 0;

      # disable dragging animation
      animate_mouse_windowdragging = false;

      # enable variable refresh rate (effective depending on hardware)
      vrr = 1;

      # focus_on_activate = true;

      # enable_swallow = true;
      swallow_regex = "foot";
      swallow_exception_regex = "";
    };

    render = {
      direct_scanout = true;
      # Fixes some apps stuttering (xournalpp, hyprlock). Possibly an amdgpu bug
      explicit_sync = 0;
      explicit_sync_kms = 0;
    };

    xwayland = {force_zero_scaling = true;};

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    debug.disable_logs = false;
  };
}
