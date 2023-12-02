{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    plugins = [pkgs.rofi-calc];
  };
  xdg.configFile."rofi" = {
    source = ./.;
    recursive = true;
  };
}
