{
  self,
  # config,
  pkgs,
  default,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    settings = {
      env = ''
        GDK_BACKEND,wayland
      '';
      exec-once = [
        "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "launch_waybar"
        "${lib.getExe pkgs.networkmanagerapplet}"
        "${lib.getExe' pkgs.wlsunset "wlsunset"} -t 5000 -S 7:00 -s 20:00"
        # "border_color"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # "${lib.getExe self.legacyPackages.${pkgs.system}.spoof-dpi}"
        "ydotoold"
        "${lib.getExe pkgs.wl-clip-persist} --clipboard both"
        "emacs --daemon"
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
        enable_swallow = true;
        swallow_regex = "^(${default.terminal.name})$";
        # swallow_exception_regex = "";
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
      "$MOD" = "SUPER";
      bind = [
        "$MOD, Return, exec, ${default.terminal.name}"
        "$MODSHIFT, Return, exec, ${default.terminal.name} --class='termfloat'"
        "$MOD, E, exec, emacs"
        "$MOD, D, exec, thunar"
        "$MOD, B, exec, [workspace name:Qutebrowser] hyprctl workspaces | rg ID | rg Qutebrowser || qutebrowser"
        "$MOD, W, exec, [workspace name:Firefox] hyprctl workspaces | rg ID | rg Firefox || firefox"
        "$MODSHIFT, W, exec, firefox --private-window"
        "$MOD, M, exec, netease-cloud-music-gtk4"
        "$MODSHIFT, M, exec, [workspace name:Music]${default.terminal.name} --class='ncmpcpp' --hold sh -c 'ncmpcpp'"
        "$MODSHIFT, X, exec, loginctl lock-session"
        "$MOD, O, exec, killall -SIGUSR1 .waybar-wrapped"
        # Rofi
        "$MOD, Space, exec, pkill rofi || ~/.config/rofi/launcher/launcher.sh"
        "$MOD, apostrophe, exec, pkill rofi || ~/.config/rofi/cliphist/cliphist-rofi.sh"
        "$MODSHIFT, P, exec, bash ~/.config/rofi/powermenu/powermenu.sh"
        "$MOD, comma, exec, bwm" # bwm for password manager
        # bind = $MODSHIFT, K, exec, pkill rofi || ~/.config/rofi/launchers/keybind.sh

        # Bookmarks
        "$MOD, semicolon, exec, pkill rofi || ~/.flakes/home/bookmarks/bm_rofi.sh"
        "$MODSHIFT, semicolon, exec, ~/.flakes/home/bookmarks/bm_this.sh"

        # Grimblast
        "$MOD, bracketleft, exec, grimblast --notify --cursor  copysave area ~/Pictures/$(date '+%Y-%m-%d'T'%H:%M:%S_no_watermark').png"
        "$MOD, bracketright, exec, grimblast --notify --cursor  copy area"
        "$MOD, A, exec, grimblast_watermark"

        ", XF86AudioRaiseVolume, exec, ${./script/volume} up"
        ", XF86AudioLowerVolume, exec, ${./script/volume} down"
        ", XF86AudioMute, exec, ${./script/volume} mute"
        ", XF86AudioMicMute, exec, ${./script/volume} mute_mic"
        ", XF86MonBrightnessUp, exec, ${./script/light} up"
        ", XF86MonBrightnessDown, exec, ${./script/light} down"
        ", XF86AudioPlay, exec, mpc -q toggle"
        ", XF86AudioNext, exec, mpc -q next"
        ", XF86AudioPrev, exec, mpc -q prev"

        "$MOD, Q, killactive"
        "$MODSHIFT, Q, exit"
        "$MODSHIFT, Space, togglefloating"
        "$MOD, F, fullscreen"
        "$MOD, M, fullscreen, 1"
        "$MOD, Y, pin"
        "$MOD, P, pseudo" # dwindle"
        "$MOD, S, togglesplit" # dwindle

        "$MODSHIFT, G, exec, hyprctl --batch 'keyword general:gaps_out 5;keyword general:gaps_in 3'"
        "$MOD, G, exec, hyprctl --batch 'keyword general:gaps_out 0;keyword general:gaps_in 0'"

        "$MOD, left, movefocus, l"
        "$MOD, right, movefocus, r"
        "$MOD, up, movefocus, u"
        "$MOD, down, movefocus, d"
        "$MOD, H, movefocus, l"
        "$MOD, L, movefocus, r"
        "$MOD, K, movefocus, u"
        "$MOD, J, movefocus, d"
        # to switch between windows in a floating workspace
        "ALT, Tab, cyclenext" # change focus to another window
        "ALT, Tab, bringactivetotop" # bring it to the top

        "${builtins.concatStringsSep "\n" (builtins.genList (x: let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
            bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            bind = $MODCTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}
          '')
          10)}"

        "$MOD, mouse_down, workspace, e-1"
        "$MOD, mouse_up, workspace, e+1"
        "$MOD, B, workspace, Qutebrowser"
        "$MOD, W, workspace, Firefox"
        "$MOD, T, workspace, TG"
        # "$MOD, M, workspace, Music"

        "$MOD, minus, movetoworkspace, special"
        "$MOD, equal, togglespecialworkspace"

        "$MODSHIFT, left, movewindow, l"
        "$MODSHIFT, right, movewindow, r"
        "$MODSHIFT, up, movewindow, u"
        "$MODSHIFT, down, movewindow, d"
      ];
      bindm = ["$MOD, mouse:272, movewindow" "$MOD, mouse:273, resizewindow"];
      windowrulev2 = [
        "animation slide right, class:^(${default.terminal.name})$"
        "center 1, class:^(firefox)$,floating:1"
        "workspace name:Firefox, class:^(firefox)$"
        "opacity 0.80 0.80, title:^(Spotify)$"
        "workspace name:Music, title:^(Spotify)$"
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

        "opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$"
        "noanim,class:^(xwaylandvideobridge)$"
        "nofocus,class:^(xwaylandvideobridge)$"
        "noinitialfocus,class:^(xwaylandvideobridge)$"
        "noblur,class:^(xwaylandvideobridge)$"
        "noshadow,class:^(xwaylandvideobridge)$"
      ];
    };
    extraConfig = ''
      #-------------------------------------------#
      # switch between current and last workspace #
      #-------------------------------------------#
      binds {
           workspace_back_and_forth = 1
           allow_workspace_cycles = 1
      }
      bind = $MOD, slash, workspace, previous
      #---------------#
      # resize window #
      #---------------#
      bind = ALT, R, submap, resize
      submap = resize
      binde = , right, resizeactive, 15 0
      binde = , left, resizeactive, -15 0
      binde = , up, resizeactive, 0 -15
      binde = , down, resizeactive, 0 15
      binde = , l, resizeactive, 15 0
      binde = , h, resizeactive, -15 0
      binde = , k, resizeactive, 0 -15
      binde = , j, resizeactive, 0 15
      bind = , escape, submap, reset
      submap = reset

      bind = CTRL SHIFT, left, resizeactive, -15 0
      bind = CTRL SHIFT, right, resizeactive, 15 0
      bind = CTRL SHIFT, up, resizeactive, 0 -15
      bind = CTRL SHIFT, down, resizeactive, 0 15
      bind = CTRL SHIFT, l, resizeactive, 15 0
      bind = CTRL SHIFT, h, resizeactive, -15 0
      bind = CTRL SHIFT, k, resizeactive, 0 -15
      bind = CTRL SHIFT, j, resizeactive, 0 15
    '';
  };
}
