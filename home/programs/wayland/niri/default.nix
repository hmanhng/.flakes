{
  pkgs,
  inputs,
  config,
  ...
}:
let
  srcPath = "${config.home.homeDirectory}/.flakes/home/programs/wayland/niri";
in
{
  imports = [ inputs.niri.homeModules.niri ];
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
  };
  home.packages = [
    inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.xwayland-satellite-unstable
  ];

  home.file = {
    ".config/niri/config.kdl".source = config.lib.file.mkOutOfStoreSymlink "${srcPath}/config.kdl";
    ".config/niri/binds.kdl".source = config.lib.file.mkOutOfStoreSymlink "${srcPath}/binds.kdl";
  };

  xdg.portal = {
    config.niri = {
      default = [
        "gnome" # required for screencasting support.
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ]; # for file chooser, no nautilus.
    };
    extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
  };
}
