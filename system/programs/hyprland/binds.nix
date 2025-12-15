let
  # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
  workspaces = builtins.concatLists (
    builtins.genList (
      x:
      let
        ws =
          let
            c = (x + 1) / 10;
          in
          builtins.toString (x + 1 - (c * 10));
      in
      [
        "$mod, ${ws}, workspace, ${toString (x + 1)}"
        "$mod SHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}"
      ]
    ) 10
  );

  toggle =
    program:
    let
      prog = builtins.substring 0 14 program;
    in
    "pkill ${prog} || uwsm app -- ${program}";

  runOnce = program: "pgrep ${program} || uwsm app -- ${program}";
in
{
  programs.hyprland = {
    settings = {
      "$MOD" = "SUPER";

      # mouse movements
      bindm = [
        "$MOD, mouse:272, movewindow"
        "$MOD, mouse:273, resizewindow"
      ];

      # binds
      bind = [
        # app
        "$MOD, Return, exec, uwsm app -- foot"
        "$MODSHIFT, Return, exec, uwsm app -- foot --app-id termfloat"
        "$MOD, E, exec, ${runOnce "emacs"}"
        "$MOD, D, exec, uwsm app -- thunar"
        "$MOD, B, exec, ${runOnce "qutebrowser"}"
        "$MOD, W, exec, ${runOnce "zen-beta"}"
        "$MODSHIFT, W, exec, uwsm app -- zen-beta --private-window"
        "$MODSHIFT, M, exec, [workspace name:Music] tidal-hifi"

        # ${runOnce "grimblast"} [screenshot]
        "$MOD, bracketleft, exec, ${runOnce "grimblast"} --notify copysave area $XDG_SCREENSHOTS_DIR/$(date '+%Y-%m-%d'T'%H:%M:%S_no_watermark').png"
        "$MOD, bracketright, exec, ${runOnce "grimblast"} --notify copy area"
        "$MODSHIFT, bracketleft, exec, ${runOnce "grimblast"} --notify --cursor copysave output $XDG_SCREENSHOTS_DIR/$(date '+%Y-%m-%d'T'%H:%M:%S_no_watermark').png"
        "$MODSHIFT, bracketright, exec, ${runOnce "grimblast"} --notify --cursor copy output"

        # compositor commands
        "$MOD, R, exec, hyprctl reload"
        "$MOD, Q, killactive"
        "$MOD, escape, exec, hyprctl kill"
        "$MODSHIFT, Q, exec, uwsm stop"
        # lock screen
        "$MODSHIFT, L, global, caelestia:lock"
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
        "${builtins.concatStringsSep "\n" (
          builtins.genList (
            x:
            let
              ws =
                let
                  c = (x + 1) / 10;
                in
                builtins.toString (x + 1 - (c * 10));
            in
            ''
              bind = $MOD, ${ws}, workspace, ${toString (x + 1)}
              bind = $MODSHIFT, ${ws}, movetoworkspace, ${toString (x + 1)}
              bind = $MODCTRL, ${ws}, movetoworkspacesilent, ${toString (x + 1)}
            ''
          ) 10
        )}"

        # to workspace
        "$MOD, mouse_down, workspace, e-1"
        "$MOD, mouse_up, workspace, e+1"
        "$MOD, B, exec, caelestia toggle qutebrowser"
        "$MOD, E, exec, caelestia toggle emacs"
        "$MOD, W, exec, caelestia toggle zen"
        "$MODSHIFT, M, exec, caelestia toggle music"

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
        "$MODCTRL, SPACE, global, caelestia:launcher"
        # launcher
        "$MOD, SPACE, exec, ${toggle "rofi"} -show combi -show-icons"
        # rofi menu
        "$MOD, apostrophe, exec, ~/.config/rofi/cliphist/cliphist-rofi.sh"
        # "$MODSHIFT, P, exec, bash ~/.config/rofi/powermenu/powermenu.sh"
        # Bookmarks
        "$MOD, semicolon, exec, ~/.flakes/home/bookmarks/bm_rofi.sh"
        "$MODSHIFT, semicolon, exec, ~/.flakes/home/bookmarks/bm_this.sh"
        # "$MOD, comma, exec, bwm" # bwm for password manager
      ];

      bindl = [
        # volume
        ", XF86AudioMute, exec,  wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

        # media control
        ", XF86AudioPlay, global, caelestia:mediaToggle"
        ", XF86AudioPause, global, caelestia:mediaToggle"
        "Ctrl+Super, Equal, global, caelestia:mediaNext"
        ", XF86AudioNext, global, caelestia:mediaNextt"
        "Ctrl+Super, Minus, global, caelestia:mediaPrev"
        ", XF86AudioPrev, global, caelestia:mediaPrev"
        ", XF86AudioStop, global, caelestia:mediaStop"
      ];

      bindle = [
        # volume
        ", XF86AudioRaiseVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 10%+"
        ", XF86AudioLowerVolume, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ 0; wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-"

        # backlight
        ", XF86MonBrightnessUp, global, caelestia:brightnessUp"
        ", XF86MonBrightnessDown, global, caelestia:brightnessDown"
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
