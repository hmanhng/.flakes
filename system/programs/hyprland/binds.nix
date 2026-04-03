let
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
      "$ipc" = "noctalia-shell ipc call";

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
        "$MOD, E, exec, ${runOnce "zeditor"}"
        "$MOD, D, exec, uwsm app -- thunar"
        # "$MOD, B, exec, uwsm app -- qutebrowser"
        "$MOD, W, exec, ${runOnce "zen-beta"}"

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
        "$MODSHIFT, L, exec, $ipc lockScreen lock"
        "$MODSHIFT, Space, togglefloating"
        "$MOD, F, fullscreen"
        "$MOD, M, fullscreen, 1"
        "$MOD, Y, pin"
        "$MOD, P, pseudo" # dwindle"
        "$MOD, S, layoutmsg, togglesplit" # dwindle

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
        "$MOD, B, workspace, Qutebrowser"
        "$MOD, E, workspace, Emacs"
        "$MOD, W, workspace, Zen"

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
        # launcher
        "$MOD, SUPER_L, exec, vicinae toggle"
      ];

      bindl = [
        # volume
        ", XF86AudioMute, exec,  $ipc volume muteOutput"
        ", XF86AudioMicMute, exec, $ipc volume muteInput"
      ];

      bindle = [
        # volume
        ", XF86AudioRaiseVolume, exec, $ipc volume increase"
        ", XF86AudioLowerVolume, exec, $ipc volume decrease"

        # backlight
        ", XF86MonBrightnessUp, exec, $ipc brightness increase"
        ", XF86MonBrightnessDown, exec, $ipc brightness decrease"
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
