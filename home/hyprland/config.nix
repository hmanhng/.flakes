{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      $mainMod = SUPER
      monitor = , preferred, auto, 1

      ## Autostart
      exec-once = launch_waybar &
      # exec-once = border_color &
      exec-once = wl-paste --type text --watch cliphist store &
      exec-once = wl-paste --type image --watch cliphist store &
      exec-once = spoof-dpi &
      exec-once = ydotoold &
      exec-once = wl-clip-persist --clipboard regular &
      exec-once = swayidle -w timeout 900 'systemctl suspend' before-sleep myswaylock

      general {
        gaps_in = 3
        gaps_out = 5
        border_size = 3
        col.active_border = rgba(F38BA8FF) rgba(A6E3A1FF) rgba(F9E2AFFF) rgba(89B4FAFF) rgba(F5C2E7FF) rgba(94E2D5FF) 45deg
        col.inactive_border = false
        no_border_on_floating = false
        layout = dwindle # master|dwindle
        cursor_inactive_timeout = 5
      }

      dwindle {
        no_gaps_when_only = false
        pseudotile = yes
        preserve_split = yes
      }
      master {
        new_is_master = true
        special_scale_factor = 0.8
        new_is_master = true
        no_gaps_when_only = false
      }

      decoration {
        rounding = 0

        active_opacity = 1.0
        inactive_opacity = 1.0
        fullscreen_opacity = 1.0

        blur {
          enabled = yes
          size = 3
          passes = 3
          new_optimizations = true
          xray = false
          ignore_opacity = false
        }
      }

      # Blurring layerSurfaces
      blurls = waybar
      blurls = rofi

      # Animations
      animations {
        enabled = true

        # bezier curve
        bezier = overshot, 0.05, 0.9, 0.1, 1.05
        # bezier = overshot, 0.13, 0.99, 0.29, 1.1
        bezier = smoothOut, 0.36, 0, 0.66, -0.56
        bezier = smoothIn, 0.25, 1, 0.5, 1

        # animation list
        animation = windows, 1, 5, overshot, slide
        animation = windowsOut, 1, 4, smoothOut, slide
        animation = windowsMove, 1, 4, default
        animation = border, 1, 10, default
        animation = fade, 1, 10, smoothIn
        animation = fadeDim, 1, 10, smoothIn
        animation = workspaces, 1, 6, overshot, slidevert
      }

      input {
        kb_layout = us
        kb_variant =
        kb_model =
        # kb_options = caps:escape
        kb_rules =
        follow_mouse = 2 # 0|1|2|3
        float_switch_override_focus = 2
        numlock_by_default = true
        touchpad {
          natural_scroll = yes
        }
        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 3
      }

      group {
        groupbar {
          font_size = 15
          render_titles = true
          gradients = true
          text_color = rgba(FFFFFFFF)
        }
      }

      misc {
        vfr = true
        disable_autoreload = true
        disable_hyprland_logo = true
        disable_splash_rendering = true
        focus_on_activate = true
        enable_swallow = false
        swallow_regex = ^(kitty)$
      }
      #---------#
      # BINDING #
      #---------#
      bind = $mainMod, Return, exec, kitty
      bind = $mainMod SHIFT, Return, exec, kitty --class="termfloat"
      bind = $mainMod, E, exec, emacs
      bind = $mainMod, Q, killactive
      bind = $mainMod SHIFT, Q, exit
      bind = $mainMod SHIFT, Space, togglefloating
      bind = $mainMod, F, fullscreen
      bind = $mainMod, Y, pin
      bind = $mainMod, P, pseudo # dwindle
      bind = $mainMod, J, togglesplit # dwindle

      #------------------------#
      # quickly launch program #
      #------------------------#
      bind = $mainMod, B, exec, [workspace name:Qutebrowser] hyprctl workspaces | rg ID | rg Qutebrowser || qutebrowser
      bind = $mainMod, W, exec, [workspace name:Firefox] hyprctl workspaces | rg ID | rg Firefox || firefox
      bind = $mainMod SHIFT, W, exec, firefox --private-window
      bind = $mainMod, M, exec, netease-cloud-music-gtk4
      bind = $mainMod SHIFT, M, exec, [workspace name:Music]kitty --class="ncmpcpp" --hold sh -c "ncmpcpp"
      bind = $mainMod SHIFT, X, exec, myswaylock

      # Rofi
      bind = $mainMod, Space, exec, pkill rofi || ~/.config/rofi/launcher/launcher.sh
      bind = CTRL, semicolon, exec, pkill rofi || ~/.config/rofi/cliphist/cliphist-rofi.sh
      bind = $mainMod SHIFT, P, exec, bash ~/.config/rofi/powermenu/powermenu.sh
      # bind = $mainMod SHIFT, K, exec, pkill rofi || ~/.config/rofi/launchers/keybind.sh

      # Bookmarks
      bind = SUPER, semicolon, exec, pkill rofi || ~/.flakes/home/bookmarks/bm_rofi.sh
      bind = SUPER SHIFT, semicolon, exec, ~/.flakes/home/bookmarks/bm_this.sh

      # Grimblast
      bind = $mainMod, bracketleft, exec, grimblast --notify --cursor  copysave area ~/Pictures/$(date "+%Y-%m-%d"T"%H:%M:%S_no_watermark").png
      bind = $mainMod, bracketright, exec, grimblast --notify --cursor  copy area
      bind = $mainMod, A, exec, grimblast_watermark

      #-----------------------#
      # Toggle grouped layout #
      #-----------------------#
      bind = $mainMod, K, togglegroup
      bind = $mainMod, Tab, changegroupactive, f

      #------------#
      # change gap #
      #------------#
      bind = $mainMod SHIFT, G, exec, hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"
      bind = $mainMod, G, exec, hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"

      #--------------------------------------#
      # Move focus with mainMod + arrow keys #
      #--------------------------------------#
      bind = $mainMod, left, movefocus, l
      bind = $mainMod, right, movefocus, r
      bind = $mainMod, up, movefocus, u
      bind = $mainMod, down, movefocus, d
      # to switch between windows in a floating workspace
      bind = ALT, Tab, cyclenext,          # change focus to another window
      bind = ALT, Tab, bringactivetotop,   # bring it to the top

      #----------------------------------------#
      # Switch workspaces with mainMod + [0-9] #
      #----------------------------------------#
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10
      bind = $mainMod, L, workspace, +1
      bind = $mainMod, H, workspace, -1
      bind = $mainMod, period, workspace, e+1
      bind = $mainMod, comma, workspace, e-1
      bind = $mainMod, B, workspace, Qutebrowser
      bind = $mainMod, W, workspace, Firefox
      bind = $mainMod, T, workspace, TG
      bind = $mainMod, M, workspace, Music

      #-------------------------------#
      # special workspace(scratchpad) #
      #-------------------------------# 
      bind = $mainMod, minus, movetoworkspace, special
      bind = $mainMod, equal, togglespecialworkspace

      #----------------------------------#
      # move window in current workspace #
      #----------------------------------#
      bind = $mainMod SHIFT, left, movewindow, l
      bind = $mainMod SHIFT, right, movewindow, r
      bind = $mainMod SHIFT, up, movewindow, u
      bind = $mainMod SHIFT, down, movewindow, d

      #---------------------------------------------------------------#
      # Move active window to a workspace with mainMod + ctrl + [0-9] #
      #---------------------------------------------------------------#
      bind = $mainMod CTRL, 1, movetoworkspace, 1
      bind = $mainMod CTRL, 2, movetoworkspace, 2
      bind = $mainMod CTRL, 3, movetoworkspace, 3
      bind = $mainMod CTRL, 4, movetoworkspace, 4
      bind = $mainMod CTRL, 5, movetoworkspace, 5
      bind = $mainMod CTRL, 6, movetoworkspace, 6
      bind = $mainMod CTRL, 7, movetoworkspace, 7
      bind = $mainMod CTRL, 8, movetoworkspace, 8
      bind = $mainMod CTRL, 9, movetoworkspace, 9
      bind = $mainMod CTRL, 0, movetoworkspace, 10
      bind = $mainMod CTRL, left, movetoworkspace, -1
      bind = $mainMod CTRL, right, movetoworkspace, +1
      # same as above, but doesnt switch to the workspace
      bind = $mainMod SHIFT, 1, movetoworkspacesilent, 1
      bind = $mainMod SHIFT, 2, movetoworkspacesilent, 2
      bind = $mainMod SHIFT, 3, movetoworkspacesilent, 3
      bind = $mainMod SHIFT, 4, movetoworkspacesilent, 4
      bind = $mainMod SHIFT, 5, movetoworkspacesilent, 5
      bind = $mainMod SHIFT, 6, movetoworkspacesilent, 6
      bind = $mainMod SHIFT, 7, movetoworkspacesilent, 7
      bind = $mainMod SHIFT, 8, movetoworkspacesilent, 8
      bind = $mainMod SHIFT, 9, movetoworkspacesilent, 9
      bind = $mainMod SHIFT, 0, movetoworkspacesilent, 10
      # Scroll through existing workspaces with mainMod + scroll
      bind = $mainMod, mouse_down, workspace, e+1
      bind = $mainMod, mouse_up, workspace, e-1

      #-------------------------------------------#
      # switch between current and last workspace #
      #-------------------------------------------#
      binds {
           workspace_back_and_forth = 1
           allow_workspace_cycles = 1
      }
      bind = $mainMod, slash, workspace, previous

      #-----------------------------------------#
      # control volume,brightness,media players-#
      #-----------------------------------------#
      bind = , XF86AudioRaiseVolume, exec, pamixer -i 5
      bind = , XF86AudioLowerVolume, exec, pamixer -d 5
      bind = , XF86AudioMute, exec, pamixer -t
      bind = , XF86AudioMicMute, exec, pamixer --default-source -t
      bind = , XF86MonBrightnessUp, exec, light -A 5
      bind = , XF86MonBrightnessDown, exec, light -U 5
      bind = , XF86AudioPlay, exec, mpc -q toggle
      bind = , XF86AudioNext, exec, mpc -q next
      bind = , XF86AudioPrev, exec, mpc -q prev

      #---------------#
      # waybar toggle #
      # --------------#
      bind = $mainMod, O, exec, killall -SIGUSR1 .waybar-wrapped

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

      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      #---------------#
      # windows rules #
      #---------------#
      #`hyprctl clients` get class、title...
      windowrule=float,title:^(Picture-in-Picture)$
      windowrule=size 960 540,title:^(Picture-in-Picture)$
      windowrule=move 25%-,title:^(Picture-in-Picture)$
      windowrule=float,imv
      windowrule=move 25%-,imv
      windowrule=size 960 540,imv
      windowrule=float,mpv
      windowrule=move 25%-,mpv
      windowrule=size 960 540,mpv
      windowrule=float,danmufloat
      windowrule=move 25%-,danmufloat
      windowrule=pin,danmufloat
      windowrule=rounding 5,danmufloat
      windowrule=size 960 540,danmufloat
      windowrule=float,termfloat
      windowrule=move 25%-,termfloat
      windowrule=size 960 540,termfloat
      windowrule=rounding 5,termfloat
      windowrule=float,nemo
      windowrule=move 25%-,nemo
      windowrule=size 960 540,nemo
      windowrule=float,pavucontrol
      windowrule=animation slide right,kitty
      windowrule=float,ncmpcpp
      windowrule=move 25%-,ncmpcpp
      windowrule=size 960 540,ncmpcpp
      windowrule=noblur,^(firefox)$

      windowrule=workspace name:Firefox, title:Mozilla Firefox
      windowrulev2=center 1, class:(firefox),floating:1
    '';
  };
}
