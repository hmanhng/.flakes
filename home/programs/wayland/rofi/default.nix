{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    # plugins = [pkgs.rofi-calc];
  };
  xdg.configFile."rofi" = {
    source = ./.;
    recursive = true;
  };
}
