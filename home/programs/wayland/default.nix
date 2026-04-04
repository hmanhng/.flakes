{
  pkgs,
  inputs,
  lib,
  ...
}:
{
  imports = [
    ./noctalia
  ];

  home.packages = with pkgs; [
    # utils
    slurp
    wl-screenrec
    wl-clipboard
    # wlr-randr
  ];

  # make stuff work on wayland
  home.sessionVariables = {
    GDK_BACKEND = "wayland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };
}
