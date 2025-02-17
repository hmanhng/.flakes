{
  pkgs,
  inputs,
  lib,
  ...
}:
# Wayland config
{
  imports = [
    # ./hyprland
    ./hyprlock.nix
    ./waybar.nix
    ./rofi
  ];

  home.packages = with pkgs; [
    # screenshot
    imagemagick # for grimblast
    inputs.hyprland-contrib.packages.${pkgs.system}.grimblast

    # utils
    wl-screenrec
    slurp
    wl-clipboard
    cliphist
    # wl-clip-persist
    wlr-randr
    hyprpicker
    # wlsunset
    ydotool
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  systemd.user.targets.tray.Unit.Requires = lib.mkForce ["graphical-session.target"];
}
