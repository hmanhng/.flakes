{pkgs, ...}: {
  # File explore
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  programs.file-roller.enable = true; # Archive manager

  services = {
    tumbler.enable = true; # Thumbnail support for images thunar
  };
}
