{ config, pkgs, user, inputs, ... }:

{
  programs.waybar = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.waybar-hyprland;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = ''
        @define-color fg-color #303446;
        @define-color bg-color #e4e8ef;
        @define-color temperature-color #f5a97f;
        @define-color cpu-color #ed8796;
        @define-color memory-color #91d7e3;
        @define-color pulseaudio-color #89b4fa;
        @define-color backlight-color #eed49f;
        @define-color network-color #cba6f7;
        @define-color network-dis-color #988ba2;
      * {
        border-radius: 5px;
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
        font-family: "Vanilla Caramel", "JetBrainsMono Nerd Font";
        font-size: 15pt;
        background-color: alpha(#303446, 0.8);
      }
      #workspaces {
        padding-left: 0px;
        padding-right: 5px;
      }
      #workspaces button {
        padding-top: 2px;
        padding-bottom: 0px;
        padding-left: 7px;
        padding-right: 7px;
        color: @bg-color;
        margin: 5px 5px 5px 0px;
      }
      #workspaces button.active {
        background-color: rgb(181, 232, 224);
        color: rgb(26, 24, 38);
        font-style: italic;
      }
      #workspaces button.urgent {
        color: rgb(26, 24, 38);
      }
      #workspaces button:hover {
        background-color: #b38dac;
        color: rgb(26, 24, 38);
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
      #window {
        font-style: italic;
      }

      #clock,
      #temperature,
      #memory,
      #cpu,
      #mpd,
      #custom-wall,
      #pulseaudio,
      #backlight,
      #network {
        border-radius: 0px 5px 5px 0px;
        padding: 3px 8px 0px 8px;
        margin: 5px 0px 5px 0px;
      }
      #temperature.icons,
      #memory.icons,
      #cpu.icons,
      #pulseaudio.icons,
      #pulseaudio.microphone-icons,
      #backlight.icons,
      #network.icons.disconnected,
      #network.icons {
        color: @fg-color;
        border-radius: 5px 0px 0px 5px;
        margin: 5px 0px 5px 10px;
      }

      #custom-launcher {
        font-size: 25px;
        padding-left: 15px;
        padding-top: 2px;
        padding-right: 15px;
        color: #8aadf4;
      }

      #custom-number-windows {
        color: @fg-color;
        background-color: #b4befe;
        padding: 3px 10px 0px 10px;
        margin: 5px 0px 5px 0px;
      }

      #temperature.icons {
        background-color: @temperature-color;
        padding: 0px 8px 0px 10px;
      }
      #temperature {
        color: @temperature-color;
        border: 2px solid @temperature-color;
      }

      #memory.icons {
        background-color: @memory-color;
        padding: 0px 8px 0px 9px;
      }
      #memory {
        color: @memory-color;
        border: 2px solid @memory-color;
      }

      #cpu.icons {
        background-color: @cpu-color;
        padding: 0px 6px 0px 8px;
      }
      #cpu {
        color: @cpu-color;
        border: 2px solid @cpu-color;
      }

      /*
              #idle_inhibitor {
              border-bottom: 3px solid #FF6699;
              }*/
      #custom-wall {
        color: #b38dac;
      }

      #clock {
        color: @bg-color;
        font-size: 17pt;
        padding: 2px 10px 0px 10px;
      }

      #pulseaudio {
        color: @pulseaudio-color;
        border: 2px solid @pulseaudio-color;
      }
      #pulseaudio.icons {
        background-color: @pulseaudio-color;
        padding: 0px 10px 0px 10px;
      }
      #pulseaudio.microphone-icons {
        background-color: @pulseaudio-color;
        padding: 0px 8px 0px 10px;
      }

      #backlight.icons {
        background-color: @backlight-color;
        padding: 0px 5px 0px 7px;
      }
      #backlight {
        color: @backlight-color;
        border: 2px solid @backlight-color;
      }

      #network.icons {
        background-color: @network-color;
        padding: 0px 10px 0px 8px;
      }
      #network.icons.disconnected {
        background-color: @network-dis-color;
      }
      #network {
        color: @network-color;
        border: 2px solid @network-color;
        padding: 2px 8px 0px 8px;
      }
      #network.disconnected {
        color: @network-dis-color;
        border: 2px solid @network-dis-color;
      }

      #battery.charging,
      #battery.discharging {
        color: @fg-color;
        background-color: #cf876f;
        margin: 5px 0px 5px 10px;
        padding: 3px 10px 0px 10px;
      }
      #battery.full,
      #battery.plugged {
        color: @fg-color;
        background-color: #a6da95;
        margin: 5px 0px 5px 10px;
        padding: 3px 10px 0px 10px;
      }
      #battery.critical:not(.charging) {
        color: #d6dce7;
      }

      #custom-powermenu {
        color: @fg-color;
        background-color: #bd6069;
        margin: 5px 5px 5px 10px;
        padding: 0px 10px 0px 10px;
      }

      #tray {
        padding-right: 10px;
        padding-left: 5px;
      }
      #tray menu {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14pt;
        background: @fg-color;
        color: @bg-color;
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
    settings = [{
      "layer" = "top";
      "position" = "top";
      "margin" = "5px 5px 0px 5px";
      modules-left = [
        "custom/launcher"
        "wlr/workspaces"
        "custom/number-windows"
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
        "custom/cava-internal"
        # "hyprland/window"
      ];
      modules-center = [ "clock" ];
      modules-right = [
        "pulseaudio#icons"
        "pulseaudio"
        "pulseaudio#microphone-icons"
        "pulseaudio#microphone"
        "backlight#icons"
        "backlight"
        "network#icons"
        "network"
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

      "wlr/workspaces" = {
        "format" = "{icon}";
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

      "temperature#icons" = { "format" = ""; "tooltip" = false; };
      "temperature" = {
        # "hwmon-path"= "${env:HWMON_PATH}";
        #"critical-threshold"= 80;
        "thermal-zone" = 2;
        "tooltip" = false;
        "format" = "{temperatureC}°C";
      };

      "memory#icons" = { "format" = "﬙"; };
      "memory" = {
        "interval" = 1;
        "format" = "{percentage}%";
        "states" = { "warning" = 85; };
      };

      "cpu#icons" = { "format" = ""; };
      "cpu" = {
        "interval" = 1;
        "format" = "{usage}%";
      };

      "idle_inhibitor" = {
        "format" = "{icon}";
        "format-icons" = { "activated" = ""; "deactivated" = ""; };
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
        "format-alt" = "<span foreground='#FF6699'>  </span>{:%A, %d %B %Y}";
        "locale" = "en_US.UTF-8";
        "interval" = 1;
        "tooltip" = true;
        "tooltip-format" = "Devops go go\n<tt>{calendar}</tt>";
      };

      "pulseaudio#icons" = {
        "format" = "{icon}";
        "format-icons" = { "headphone" = ""; "hands-free" = ""; "headset" = ""; "phone" = ""; "portable" = ""; "car" = ""; "default" = [ "󰕿" "󰖀" "󰕾" ]; };
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
        "format-icons" = [ "" "" "" "" ];
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
        "interval" = 1;
        "tooltip" = false;
      };
      "network" = {
        "format-disconnected" = "Disconnected";
        "format-ethernet" = "{ifname} ({ipaddr})";
        "format-linked" = "{essid} (No IP)";
        "format-wifi" = "{essid}";
        "interval" = 1;
        "tooltip" = false;
      };

      "battery" = {
        "format" = "{icon} {capacity}%";
        "format-charging" = "󰚥 {capacity}%";
        "format-full" = "󰚥 Full";
        "format-plugged" = "󰚥 Full";
        "format-icons" = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
        "interval" = 10;
        "states" = { "critical" = 10; "warning" = 20; };
        "full-at" = 96;
        "tooltip" = true;
      };

      "custom/powermenu" = {
        "format" = "";
        "on-click" = "pkill rofi || ~/.config/rofi/powermenu.sh";
        "tooltip" = false;
      };

      "tray" = {
        # "icon-size" = 15;
        "spacing" = 5;
      };
    }];
  };
}
