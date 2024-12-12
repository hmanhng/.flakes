{
  pkgs,
  inputs,
  ...
}:
# Wayland config
{
  imports = [
    ./hyprland
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
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  # fake a tray to let apps start
  # https://github.com/nix-community/home-manager/issues/2064
  # systemd.user.targets.tray = {
  #   Unit = {
  #     Description = "Home Manager System Tray";
  #     Requires = ["graphical-session-pre.target"];
  #   };
  # };
}
