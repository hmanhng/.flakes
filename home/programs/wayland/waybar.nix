{
  pkgs,
  lib,
  ...
}: let
  launch_waybar = pkgs.writeShellScriptBin "launch_waybar" ''
    killall .waybar-wrapped
    SDIR="$HOME/.config/waybar"
    waybar -c "$SDIR"/config -s "$SDIR"/style.css > /dev/null 2>&1 &
  '';

  warp = pkgs.writeShellScriptBin "warp" ''
    status=$(curl -s https://www.cloudflare.com/cdn-cgi/trace/ | grep 'warp=' | cut -d= -f2)
    [ "$status" == "on" ] && tooltip="Connected" || tooltip="Disconnected"
    check() {
      printf '{"class": "%s", "tooltip": "%s"}\n' "$status" "$tooltip"
    }
    toggle() {
      if [ "$status" == "on" ]; then
        warp-cli disconnect
        notify-send warp-cli Disconnect
      else
        warp-cli connect
        notify-send warp-cli Connect
      fi
    }
    [ "$1" == "toggle" ] && toggle || check
  '';
in {
  home.packages = with pkgs; [
    launch_waybar
    warp
  ];
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
      * {
        border-radius: 0px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      @keyframes blink_red {
        to {
          background-color: rgb(242, 143, 173);
          color: rgb(26, 24, 38);
          border-bottom: none;
        }
      }
      .warning,
      .critical,
      .urgent {
        animation-name: blink_red;
        animation-duration: 1s;
        animation-timing-function: steps(12);
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      window#waybar {
        font-family: Iosevka Nerd Font;
        /* font-weight: bold; */
        font-size: 13pt;
        background-color: alpha(@base, 0.9);
      }
      #workspaces {
        font-family: Maple Mono NF;
      }
      #workspaces button {
        padding: 0px 6px 0px 6px;
        color: @text;
      }
      #workspaces button.active {
        background-color: #b5e8e0;
        color: #1a1826;
        font-style: italic;
      }
      #workspaces button.urgent {
        color: #1a1826;
      }
      #workspaces button:hover {
        background-color: #b38dac;
        color: #1a1826;
      }
      tooltip {
        /* background: rgb(250, 244, 252); */
        background: #3b4253;
      }
      tooltip label {
        font-family: Maple Mono NF;
        /* font-weight: bold; */
        font-size: 12pt;
        color: #e4e8ef;
      }
      #temperature,
      #memory,
      #cpu,
      #mpd,
      #custom-wall,
      #pulseaudio,
      #backlight,
      #network,
      #battery {
        border-bottom: 2px solid transparent;
        padding: 0px 5px 0px 0px;
        margin: 0px 2px 0px 0px;
      }
      #temperature.icons,
      #memory.icons,
      #cpu.icons,
      #pulseaudio.icons,
      #pulseaudio.microphone-icons,
      #backlight.icons,
      #network.speed,
      #network.icons,
      #battery.icons {
        padding: 0px 5px 0px 5px;
        margin: 0px 0px 0px 2px;
      }

      #custom-launcher,
      #custom-hyprpicker,
      #custom-screenshot {
        font-family: JetBrainsMono Nerd Font;
        font-size: 20px;
      }
      #custom-launcher {
        padding: 0px 7px 0px 7px;
        color: @blue;
      }
      #custom-hyprpicker {
        padding: 0px 5px 0px 3px;
        color: @sapphire;
      }
      #custom-screenshot {
        padding: 0px 17px 0px 5px;
        color: @lavender;
      }

      #custom-number-windows {
        color: @bg-color;
        background-color: #b4befe;
        padding: 0px 10px 0px 10px;
      }

      #temperature.icons,
      #temperature {
        color: @red;
        border-bottom-color: @red;
      }

      #memory.icons,
      #memory {
        color: @lavender;
        border-bottom-color: @lavender;
      }

      #cpu.icons,
      #cpu {
        color: @pink;
        border-bottom-color: @pink;
      }

      /* #idle_inhibitor {
      border-bottom: 3px solid #FF6699;
      } */

      #custom-wall {
        color: #b38dac;
      }

      #clock {
        color: @rosewater;
        font-size: 14pt;
        padding: 0px 10px 0px 10px;
      }

      #custom-warp.on {
        color: #F68D29;
      }
      #custom-warp.off {
        color: @network-dis-color;
      }

      #pulseaudio,
      #pulseaudio.icons,
      #pulseaudio.microphone-icons {
        color: @sky;
        border-bottom-color: @sky;
      }

      #backlight.icons,
      #backlight {
        color: @yellow;
        border-bottom-color: @yellow;
      }

      #network.speed {
        color: @mauve;
        border-bottom-color: @mauve;
      }
      #network.icons,
      #network {
        color: @peach;
        border-bottom-color: @peach;
      }
      #network.disconnected {
        color: #988ba2;
        border-bottom-color: @surface1;
        margin: 0px 2px 0px 2px;
      }

      #battery.discharging {
        color: @text;
        border-bottom-color: @text;
      }
      #battery.full,
      #battery.plugged,
      #battery.charging {
        color: @green;
        border-bottom-color: @green;
      }
      #battery.critical:not(.charging) {
        color: @text;
      }

      #custom-poweroff {
        color: #ff6c6b;
        padding: 0px 9px 0px 9px;
      }
      #custom-reboot {
        color: #ecbe7b;
        padding: 0px 9px 0px 9px;
      }
      #custom-suspend {
        color: #4db5bd;
        padding: 0px 7px 0px 7px;
      }
      #custom-lockscreen {
        color: #c678dd;
        padding: 0px 9px 0px 9px;
      }

      #tray {
        padding-right: 10px;
        padding-left: 5px;
      }
      #tray menu {
        font-family: JetBrainsMono Nerd Font;
        font-size: 12pt;
        background: alpha(@base, 0.9);
        color: @fg-color;
      }

      #mpd.paused {
        color: rgb(192, 202, 245);
        font-style: italic;
      }
      #mpd.stopped {
        background: transparent;
      }
      #mpd {
        color: #e4e8ef;
        padding-left: 15px;

        /* color: #c0caf5; */
      }
      #custom-cava-internal {
        font-family: Liga CodeNewRoman Nerd Font, JetBrainsMono Nerd Font;
        font-weight: bold;
        padding-left: 0px;
        padding-right: 5px;
        color: #cccccc;
      }
    '';
    settings = [
      {
        layer = "top";
        position = "top";
        # mode = "dock";
        # margin = "5px 5px 0px 5px";
        modules-left = [
          "group/launcher"
          "hyprland/workspaces"
          # "custom/number-windows"
          "hyprland/submap"
          "temperature#icons"
          "temperature"
          "memory#icons"
          "memory"
          "cpu#icons"
          "cpu"
          "network#speed"
          # "idle_inhibitor"
          # "custom/wall"
          "mpd"
          # "custom/cava-internal"
          # "hyprland/window"
        ];
        modules-center = ["clock"];
        modules-right = [
          # "custom/warp"
          # "group/audio"
          "pulseaudio#icons"
          "pulseaudio"
          "pulseaudio#microphone-icons"
          "pulseaudio#microphone"

          # "group/backlight"
          "backlight#icons"
          "backlight"
          # "group/bat"
          "network#icons"
          "network"
          "battery#icons"
          "battery"
          "group/powermenu"
          "tray"
        ];

        "group/launcher" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "launcher-group";
            transition-left-to-right = true;
          };
          modules = ["custom/launcher" "custom/hyprpicker" "custom/screenshot"];
        };
        "custom/launcher" = {
          format = "";
          on-click = "uwsm app -- foot";
          # on-click-middle = "default_wall";
          # on-click-right = "killall dynamic_wallpaper || dynamic_wallpaper &";
          # on-click = "pkill rofi || ~/.config/rofi/launcher.sh";
          tooltip = false;
        };
        "custom/hyprpicker" = {
          format = "";
          on-click = "hyprpicker -a && notify-send Hyprpicker \"$(wl-paste)\"";
          tooltip = false;
        };
        "custom/screenshot" = {
          format = "󰸉";
          on-click = "grimblast --notify copy area";
          on-click-right = "grimblast --notify copysave area $XDG_SCREENSHOTS_DIR/$(date \"+%Y-%m-%d\"T\"%H:%M:%S_no_watermark\").png";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          # on-scroll-up = "hyprctl dispatch workspace e+1";
          # on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        "custom/number-windows" = {
          exec = "hyprctl activeworkspace | rg windows | cut -d \" \" -f2";
          restart-interval = 1;
          format = "󰹑   {}";
          tooltip = false;
        };

        "hyprland/submap" = {
          format = "submap = {} ";
          # max-length = 8;
          # tooltip = false;
        };

        "temperature#icons" = {
          format = "temp";
          tooltip = false;
        };
        temperature = {
          # hwmon-path= "${env:HWMON_PATH}";
          #critical-threshold= 80;
          # thermal-zone = 2;
          tooltip = false;
          format = "{temperatureC}°C";
        };

        "memory#icons" = {format = "mem";};
        memory = {
          interval = 10;
          format = "{percentage}%";
          states = {"warning" = 85;};
        };

        "cpu#icons" = {format = "cpu";};
        cpu = {
          interval = 10;
          format = "{usage}%";
        };

        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "";
            deactivated = "";
          };
          tooltip = false;
        };

        "custom/wall" = {
          on-click = "wallpaper_random";
          on-click-middle = "default_wall";
          on-click-right = "killall dynamic_wallpaper || dynamic_wallpaper &";
          format = " ﴔ ";
          tooltip = false;
        };

        mpd = {
          max-length = 25;
          format = "<span foreground='#bb9af7'> </span>{title}";
          format-paused = " {title}";
          format-stopped = "<span foreground='#bb9af7'> </span>";
          format-disconnected = "";
          on-click = "mpc --quiet toggle";
          on-click-right = "mpc update; mpc ls | mpc add";
          on-click-middle = "foot --app-id ncmpcpp ncmpcpp";
          on-scroll-up = "mpc --quiet prev";
          on-scroll-down = "mpc --quiet next";
          smooth-scrolling-threshold = 5;
          tooltip-format = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };

        "custom/cava-internal" = {
          exec = "sleep 1s && cava-internal";
          tooltip = false;
        };

        clock = {
          format = "{:%H:%M}";
          format-alt = "{:%d %B %Y (%a)}";
          locale = "en_US.UTF-8";
          tooltip-format = "Devops go go\n<span size='13pt' font='Maple Mono NF'>{calendar}</span>";
          calendar = {
            mode-mon-col = 3;
            # weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#ffead3'><b>{}</b></span>";
              days = "<span color='#ecc6d9'><b>{}</b></span>";
              weeks = "<span color='#99ffdd'><b>W{}</b></span>";
              weekdays = "<span color='#ffcc66'><b>{}</b></span>";
              today = "<span color='#ff6699'><b><u>{}</u></b></span>";
            };
          };
          actions = {
            on-click-right = "mode";
            on-click-forward = "tz_up";
            on-click-backward = "tz_down";
            on-scroll-up = "shift_up";
            on-scroll-down = "shift_down";
          };
        };

        "custom/warp" = {
          format = "1.1.1.1";
          exec = "${lib.getExe warp}";
          on-click = "${lib.getExe warp} toggle; pkill -SIGRTMIN+10 waybar";
          return-type = "json";
          interval = "once";
          signal = 10;
        };

        "network#speed" = {
          format = "󰄿{bandwidthUpBytes} 󰄼{bandwidthDownBytes}";
          interval = 5;
          tooltip = false;
        };
        "network#icons" = {
          format-disconnected = "disconnected";
          format-ethernet = "net";
          format-wifi = "wifi";
          tooltip = false;
        };
        network = {
          # format-disconnected = "Disconnected";
          format-ethernet = "{ifname}";
          format-linked = "{essid} (No IP)";
          format-wifi = "{essid}"; # show default gateway for login wifi
          tooltip = true;
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{ifname} via {gwaddr} ({signalStrength}%)";
        };

        "group/audio" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "audio-group";
            transition-left-to-right = false;
          };
          modules = ["pulseaudio#icons" "pulseaudio#microphone" "pulseaudio#microphone-icons" "pulseaudio"];
        };
        "pulseaudio#icons" = {
          format = "vol";
          on-click = "pamixer -t";
          on-click-right = "pwvucontrol";
          scroll-step = 2;
          tooltip = false;
        };
        pulseaudio = {
          format = "{volume}%";
          # format-bluetooth = " {volume}%";
          format-muted = "muted";
          on-click = "pamixer -t";
          on-click-right = "pwvucontrol";
          scroll-step = 2;
          tooltip = false;
        };

        "pulseaudio#microphone-icons" = {
          format = "mic";
          on-click = "pamixer --default-source -t";
          on-click-right = "pwvucontrol";
          on-scroll-down = "pamixer --default-source -d 2";
          on-scroll-up = "pamixer --default-source -i 2";
          tooltip = false;
        };
        "pulseaudio#microphone" = {
          format = "{format_source}";
          format-source = "{volume}%";
          format-source-muted = "muted";
          on-click = "pamixer --default-source -t";
          on-click-right = "pwvucontrol";
          on-scroll-down = "pamixer --default-source -d 2";
          on-scroll-up = "pamixer --default-source -i 2";
          tooltip = false;
        };

        "group/backlight" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "blacklight-group";
            transition-left-to-right = false;
          };
          modules = ["backlight#icons" "backlight"];
        };
        "backlight#icons" = {
          on-scroll-up = "brillo -A 2";
          on-scroll-down = "brillo -U 2";
          format = "light";
          tooltip = false;
        };
        backlight = {
          on-scroll-up = "brillo -A 2";
          on-scroll-down = "brillo -U 2";
          format = "{percent}%";
          tooltip = false;
        };

        "group/bat" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "bat-group";
            transition-left-to-right = false;
          };
          modules = ["battery#icons" "battery"];
        };
        "battery#icons" = {
          format = "bat";
          states = {
            critical = 10;
            warning = 20;
          };
          tooltip = true;
        };
        battery = {
          format = "{capacity}%";
          states = {
            critical = 10;
            warning = 20;
          };
          tooltip = true;
        };

        "group/powermenu" = {
          orientation = "inherit";
          drawer = {
            transition-duration = 500;
            children-class = "powermenu-group";
            transition-left-to-right = false;
          };
          modules = ["custom/poweroff" "custom/lockscreen" "custom/suspend" "custom/reboot"];
        };
        "custom/poweroff" = {
          format = "";
          on-click = "systemctl poweroff";
          tooltip = false;
        };
        "custom/reboot" = {
          format = "";
          on-click = "systemctl reboot";
          tooltip = false;
        };
        "custom/suspend" = {
          format = "";
          on-click = "systemctl suspend";
          tooltip = false;
        };
        "custom/lockscreen" = {
          format = "󰌾";
          on-click = "loginctl lock-session";
          tooltip = false;
        };

        tray = {
          # icon-size = 15;
          spacing = 5;
        };
      }
    ];
  };
}
