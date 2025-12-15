{
  lib,
  config,
  pkgs,
  ...
}:
{
  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
    gtk.enable = true;
  };

  gtk = {
    enable = true;

    font = {
      name = "IBM Plex Mono";
      size = 12;
    };

    gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };

    theme = {
      name = "Nordic";
      package = pkgs.nordic;
    };
  };

  xdg.configFile."gtk-4.0/gtk.css".enable = lib.mkForce false;
}
