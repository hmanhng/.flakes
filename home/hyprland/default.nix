{ config, lib, pkgs, inputs', ... }:

{
  imports = [
    ./config.nix
    ../gtk.nix
    ../scripts
    ../packages
    ../packages/waybar/hyprland_waybar.nix
  ] ++
  (import ../shell) ++
  (import ../editors);

  programs.fish.loginShellInit = ''
    set TTY1 (tty)
    [ "$TTY1" = "/dev/tty1" ] && exec Hyprland
  '';
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    enableNvidiaPatches = false;
  };
  systemd.user.targets.hyprland-session.Unit.Wants = [ "xdg-desktop-autostart.target" ];

  home.packages = with pkgs; [
    ## Requirement for hyprland
    alsa-lib
    cliphist
    imagemagick # for grimblast
    inputs'.hypr-contrib.packages.grimblast
    inputs'.hyprpicker.packages.hyprpicker
    killall
    pamixer
    socat
    swayidle
    swaylock-effects
    wl-clipboard
    wl-clip-persist
    wlr-randr
    wf-recorder
    xdg-utils
    ydotool
  ];

  home = {
    sessionVariables = {
      XDG_CACHE_HOME = "$HOME/.cache";
      XDG_CONFIG_HOME = "$HOME/.config";
      XDG_BIN_HOME = "$HOME/.local/bin";
      XDG_DATA_HOME = "$HOME/.local/share";
      XDG_STATE_HOME = "$HOME/.local/state";

      NIXOS_OZONE_WL = "1";
      QT_SCALE_FACTOR = "1.25";
      SDL_VIDEODRIVER = "wayland";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      CLUTTER_BACKEND = "wayland";
      XDG_CURRENT_DESKTOP = "Hyprland";
      XDG_SESSION_DESKTOP = "Hyprland";

      GNUHOME = "$HOME/.local/share/gnupg";
      NODE_PATH = "$HOME/.local/share/npm-packages/lib/node_modules";
      CARGO_HOME = "$HOME/.local/share/cargo";
      GOPATH = "$HOME/.local/share/go";
    };
    sessionPath = [
      "$HOME/.local/bin"
      "$HOME/.local/share/npm-packages/bin"
    ];
  };
}
