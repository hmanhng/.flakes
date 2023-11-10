{
  config,
  pkgs,
  user,
  inputs',
  ...
}: {
  systemd.user.targets.tray = {
    Unit = {
      Description = "Home Manager System Tray";
      Requires = ["graphical-session-pre.target"];
    };
  };
  programs.waybar = {
    enable = true;
    /*
    package = inputs'.hyprland.packages.waybar-hyprland;
    */
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
        @define-color bg-color alpha(#303446, 0.8);
        @define-color fg-color #e4e8ef;
        @define-color temperature-color #f5a97f;
        @define-color cpu-color #ed8796;
        @define-color memory-color #91d7e3;
        @define-color pulseaudio-color #89b4fa;
        @define-color backlight-color #eed49f;
        @define-color network-color #cba6f7;
        @define-color network-dis-color #988ba2;
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
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }
      window#waybar {
        font-family: "Operator Mono Lig", "JetBrainsMono Nerd Font";
        /* font-weight: bold; */
        font-size: 15pt;
        background-color: @bg-color;
      }
      #workspaces {
        padding-left: 0px;
        padding-right: 0px;
      }
      #workspaces button {
        padding: 0px 6px 0px 6px;
        color: @fg-color;
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
        font-family: "Liga CodeNewRoman Nerd Font";
        font-weight: bold;
        font-size: 14pt;
        color: #e4e8ef;
      }
      /* #temperature,
      #memory,
      #cpu,
      #mpd,
      #custom-wall,
      #pulseaudio,
      #backlight,
      #network {
        color: @bg-color;
        border-radius: 0px 5px 5px 0px;
        padding: 3px 8px 0px 0px;
        margin: 5px 0px 5px 0px;
      } */
      /* #temperature.icons,
      #memory.icons,
      #cpu.icons,
      #pulseaudio.icons,
      #pulseaudio.microphone-icons,
      #backlight.icons,
      #network.icons.disconnected,
      #network.icons {
        padding: 0px 5px 0px 10px;
      } */

      #custom-launcher {
        font-size: 25px;
        padding: 0px 7px 0px 7px;
        color: #6db7f7;
      }

      #custom-number-windows {
        color: @bg-color;
        background-color: #b4befe;
        padding: 0px 10px 0px 10px;
      }

      #temperature.icons {
        color: @temperature-color;
        padding: 0px 4px 0px 10px;
      }
      #temperature {
        color: @temperature-color;
      }

      #memory.icons {
        color: @memory-color;
        padding: 0px 4px 0px 10px;
      }
      #memory {
        color: @memory-color;
      }

      #cpu.icons {
        color: @cpu-color;
        padding: 0px 3px 0px 10px;
      }
      #cpu {
        color: @cpu-color;
      }

      /*
              #idle_inhibitor {
              border-bottom: 3px solid #FF6699;
              }*/
      #custom-wall {
        color: #b38dac;
      }

      #clock {
        color: @fg-color;
        font-size: 17pt;
        padding: 0px 10px 0px 10px;
      }

      #pulseaudio {
        color: @pulseaudio-color;
      }
      #pulseaudio.icons {
        color: @pulseaudio-color;
        padding: 0px 6px 0px 10px;
      }
      #pulseaudio.microphone-icons {
        color: @pulseaudio-color;
        padding: 0px 3px 0px 10px;
      }

      #backlight.icons {
        color: @backlight-color;
        padding: 0px 2px 0px 10px;
      }
      #backlight {
        color: @backlight-color;
      }

      #network.icons,
      #network.icons.disconnected {
        padding: 0px 8px 0px 10px;
      }
      #network {
        color: @network-color;
      }
      #network.disconnected {
        color: @network-dis-color;
      }

      #battery.icons.charging,
      #battery.icons.discharging,
      #battery.icons.full,
      #battery.icons.plugged {
        padding: 0px 3px 0px 10px;
      }
      #battery.charging,
      #battery.discharging {
        color: #cf876f;
        padding: 0px 10px 0px 0px;
      }
      #battery.full,
      #battery.plugged {
        color: #a6da95;
        padding: 0px 10px 0px 0px;
      }
      #battery.critical:not(.charging) {
        color: #d6dce7;
      }

      #custom-powermenu {
        color: @bg-color;
        background-color: #bd6069;
        padding: 0px 9px 0px 9px;
      }

      #tray {
        padding-right: 10px;
        padding-left: 10px;
      }
      #tray menu {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14pt;
        background: @bg-color;
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
        font-family: "Liga CodeNewRoman Nerd Font", "JetBrainsMono Nerd Font";
        font-weight: bold;
        padding-left: 0px;
        padding-right: 5px;
        color: #cccccc;
      }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        /*
        "mode" = "dock";
        */
        /*
        "margin" = "5px 5px 0px 5px";
        */
        modules-left = [
          "custom/launcher"
          "hyprland/workspaces"
          # "custom/number-windows"
          "hyprland/submap"
          "temperature#icons"
          "temperature"
          "memory#icons"
          "memory"
          "cpu#icons"
          "cpu"
          # "idle_inhibitor"
          # "custom/wall"
          "mpd"
          # "custom/cava-internal"
          # "hyprland/window"
        ];
        modules-center = ["clock"];
        modules-right = [
          "pulseaudio#icons"
          "pulseaudio"
          "pulseaudio#microphone-icons"
          "pulseaudio#microphone"
          "backlight#icons"
          "backlight"
          "network#icons"
          "network"
          "battery#icons"
          "battery"
          "custom/powermenu"
          "tray"
        ];
        "custom/spacer" = {
          "format" = " ";
          "tooltip" = false;
        };

        "custom/launcher" = {
          "format" = "";
          "on-click" = "wallpaper_random";
          "on-click-middle" = "default_wall";
          "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
          # "on-click" = "pkill rofi || ~/.config/rofi/launcher.sh";
          "tooltip" = false;
        };

        "hyprland/workspaces" = {
          "format" = "{name}";
          "on-click" = "activate";
          # "on-scroll-up" = "hyprctl dispatch workspace e+1";
          # "on-scroll-down" = "hyprctl dispatch workspace e-1";
        };

        "custom/number-windows" = {
          "exec" = "hyprctl activeworkspace | rg windows | cut -d \" \" -f2";
          "restart-interval" = 1;
          "format" = "󰹑   {}";
          "tooltip" = false;
        };

        "hyprland/submap" = {
          "format" = "submap= {} ";
          # "max-length" = 8;
          # "tooltip" = false;
        };

        "temperature#icons" = {
          "format" = "";
          "tooltip" = false;
        };
        "temperature" = {
          # "hwmon-path"= "${env:HWMON_PATH}";
          #"critical-threshold"= 80;
          "thermal-zone" = 2;
          "tooltip" = false;
          "format" = "{temperatureC}°C";
        };

        "memory#icons" = {"format" = "﬙";};
        "memory" = {
          "interval" = 10;
          "format" = "{percentage}%";
          "states" = {"warning" = 85;};
        };

        "cpu#icons" = {"format" = "";};
        "cpu" = {
          "interval" = 10;
          "format" = "{usage}%";
        };

        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };

        "custom/wall" = {
          "on-click" = "wallpaper_random";
          "on-click-middle" = "default_wall";
          "on-click-right" = "killall dynamic_wallpaper || dynamic_wallpaper &";
          "format" = " ﴔ ";
          "tooltip" = false;
        };

        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'> </span>{title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'> </span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };

        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
          "tooltip" = false;
        };

        "clock" = {
          "format" = "{:%H:%M}";
          "format-alt" = "<span foreground='#FF6699'> </span>{:%d %B %Y (%a)}";
          "locale" = "en_US.UTF-8";
          "interval" = 60;
          "tooltip" = true;
          "tooltip-format" = "Devops go go\n<tt>{calendar}</tt>";
        };

        "pulseaudio#icons" = {
          "format" = "{icon}";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = ["󰕿" "󰖀" "󰕾"];
          };
          "format-muted" = "婢";
          "on-click" = "pamixer -t";
          "on-click-right" = "pavucontrol";
          "scroll-step" = 5;
          "tooltip" = false;
        };
        "pulseaudio" = {
          "format" = "{volume}%";
          "format-bluetooth" = " {volume}%";
          "format-muted" = "Muted";
          "on-click" = "pamixer -t";
          "on-click-right" = "pavucontrol";
          "scroll-step" = 5;
          # "states" = { "warning" = 85; };
          "tooltip" = false;
        };

        "pulseaudio#microphone-icons" = {
          "format" = "{format_source}";
          "format-source" = "";
          "format-source-muted" = "";
          "on-click" = "pamixer --default-source -t";
          "on-click-right" = "pavucontrol";
          "on-scroll-down" = "pamixer --default-source -d 5";
          "on-scroll-up" = "pamixer --default-source -i 5";
          "scroll-step" = 5;
          "tooltip" = false;
        };
        "pulseaudio#microphone" = {
          "format" = "{format_source}";
          "format-source" = "{volume}%";
          "format-source-muted" = "Muted";
          "on-click" = "pamixer --default-source -t";
          "on-click-right" = "pavucontrol";
          "on-scroll-down" = "pamixer --default-source -d 5";
          "on-scroll-up" = "pamixer --default-source -i 5";
          "scroll-step" = 5;
          "tooltip" = false;
        };

        "backlight#icons" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = "{icon}";
          "format-icons" = ["" "" "" ""];
          "tooltip" = false;
        };
        "backlight" = {
          "device" = "intel_backlight";
          "on-scroll-up" = "light -A 5";
          "on-scroll-down" = "light -U 5";
          "format" = "{percent}%";
          "tooltip" = false;
        };

        "network#icons" = {
          "format-disconnected" = "󰞃";
          "format-ethernet" = "";
          "format-linked" = "󰯡";
          "format-wifi" = "󰒢";
          "tooltip" = false;
        };
        "network" = {
          "format-disconnected" = "Disconnected";
          "format-ethernet" = "{ifname} ({ipaddr})";
          "format-linked" = "{essid} (No IP)";
          "format-wifi" = "{essid}";
          "tooltip" = false;
        };

        "battery#icons" = {
          "format" = "{icon}";
          "format-charging" = "󰚥";
          "format-full" = "󰚥";
          "format-plugged" = "󰚥";
          "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
          "states" = {
            "critical" = 10;
            "warning" = 20;
          };
          "full-at" = 96;
          "tooltip" = true;
        };
        "battery" = {
          "format" = "{capacity}%";
          "format-charging" = "{capacity}%";
          "format-full" = "Full";
          "format-plugged" = "Full";
          "states" = {
            "critical" = 10;
            "warning" = 20;
          };
          "full-at" = 96;
          "tooltip" = true;
        };

        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu/powermenu.sh";
          "tooltip" = false;
        };

        "tray" = {
          # "icon-size" = 15;
          "spacing" = 5;
        };
      }
    ];
  };
}
