{
  wayland.windowManager.hyprland = {
    settings = {
      "$MOD" = "SUPER";

      # mouse movements
      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];

      # binds
      bind = [
        # utility
        # terminal
        "$MOD, Return, exec, kitty"
        "$MODSHIFT, Return, exec, kitty --class='termfloat'"
        # emacs
        "$MOD, E, exec, [workspace name:Emacs] hyprctl workspaces | rg ID | rg Emacs || emacsclient -c -a 'emacs'"
        # file manager
        "$MOD, D, exec, thunar"
        # browser
        "$MOD, B, exec, [workspace name:Qutebrowser] hyprctl workspaces | rg ID | rg Qutebrowser || qutebrowser"
        "$MOD, W, exec, [workspace name:Firefox] hyprctl workspaces | rg ID | rg Firefox || firefox"
        "$MODSHIFT, W, exec, firefox --private-window"
        # music
        # "$MOD, M, exec, spotify"
        "$MODSHIFT, M, exec, [workspace name:Music]kitty --class='ncmpcpp' --hold sh -c 'ncmpcpp'"

        # launcher
        "$MOD, Space, exec, pkill rofi || rofi -show combi"
        # rofi menu
        "$MOD, apostrophe, exec, pkill rofi || ~/.config/rofi/cliphist/cliphist-rofi.sh"
        # "$MODSHIFT, P, exec, bash ~/.config/rofi/powermenu/powermenu.sh"
        # Bookmarks
        "$MOD, semicolon, exec, pkill rofi || ~/.flakes/home/bookmarks/bm_rofi.sh"
        "$MODSHIFT, semicolon, exec, ~/.flakes/home/bookmarks/bm_this.sh"
        "$MOD, comma, exec, bwm" # bwm for password manager

        # lock screen
        "$MODSHIFT, X, exec, loginctl lock-session"

        # hide/unhide waybar
        "$MOD, O, exec, killall -SIGUSR1 .waybar-wrapped"

        # grimblast [screenshot]
        "$MOD, bracketleft, exec, grimblast --notify --cursor  copysave area ~/Pictures/$(date '+%Y-%m-%d'T'%H:%M:%S_no_watermark').png"
        "$MOD, bracketright, exec, grimblast --notify --cursor  copy area"
        "$MODSHIFT, bracketleft, exec, grimblast --notify --cursor  copysave ~/Pictures/$(date '+%Y-%m-%d'T'%H:%M:%S_no_watermark').png"
        "$MODSHIFT, bracketright, exec, grimblast --notify --cursor  copy"
        "$MOD, A, exec, grimblast_watermark"

        # compositor commands
        "$MOD, Q, killactive"
        "$MODSHIFT, Q, exit"
        "$MODSHIFT, Space, togglefloating"
        "$MOD, F, fullscreen"
        "$MOD, M, fullscreen, 1"
        "$MOD, Y, pin"
        "$MOD, P, pseudo" # dwindle"
        "$MOD, S, togglesplit" # dwindle

        # change gap
        "$MODSHIFT, G, exec, hyprctl --batch 'keyword general:gaps_out 5;keyword general:gaps_in 3'"
        "$MOD, G, exec, hyprctl --batch 'keyword general:gaps_out 0;keyword general:gaps_in 0'"

        # move focus
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

        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        "${builtins.concatStringsSep "\n" (builtins.genList (x: let
            ws = let c = (x + 1) / 10; in builtins.toString (x + 1 - (c * 10));
          in ''
            bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
            bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
            bind = $MODCTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}
          '')
          10)}"

        # to workspace
        "$MOD, mouse_down, workspace, e-1"
        "$MOD, mouse_up, workspace, e+1"
        "$MOD, B, workspace, Qutebrowser"
        "$MOD, E, workspace, Emacs"
        "$MOD, W, workspace, Firefox"
        "$MOD, T, workspace, TG"
        # "$MOD, M, workspace, Music"

        # to workspace special
        "$MOD, minus, movetoworkspace, special"
        "$MOD, equal, togglespecialworkspace"

        # move window
        "$MODSHIFT, left, movewindow, l"
        "$MODSHIFT, right, movewindow, r"
        "$MODSHIFT, up, movewindow, u"
        "$MODSHIFT, down, movewindow, d"
      ];

      bindr = [
      ];

      bindl = [
        # volume
        ", XF86AudioMute, exec, ${./script/volume} mute"
        ", XF86AudioMicMute, exec, ${./script/volume} mute_mic"

        # media control
        ", XF86AudioPlay, exec, mpc -q toggle"
        ", XF86AudioNext, exec, mpc -q next"
        ", XF86AudioPrev, exec, mpc -q prev"
      ];

      bindle = [
        # volume
        ", XF86AudioRaiseVolume, exec, ${./script/volume} up"
        ", XF86AudioLowerVolume, exec, ${./script/volume} down"

        # backlight
        ", XF86MonBrightnessUp, exec, ${./script/light} up"
        ", XF86MonBrightnessDown, exec, ${./script/light} down"
      ];

      binde = [
        "CTRL SHIFT, left, resizeactive, -15 0"
        "CTRL SHIFT, right, resizeactive, 15 0"
        "CTRL SHIFT, up, resizeactive, 0 -15"
        "CTRL SHIFT, down, resizeactive, 0 15"
        "CTRL SHIFT, l, resizeactive, 15 0"
        "CTRL SHIFT, h, resizeactive, -15 0"
        "CTRL SHIFT, k, resizeactive, 0 -15"
        "CTRL SHIFT, j, resizeactive, 0 15"
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
    '';
  };
}
