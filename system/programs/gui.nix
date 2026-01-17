{ pkgs, ... }:
{
  # File explore
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
    ];
  };
  environment.systemPackages = [
    pkgs.file-roller
  ];

  services = {
    tumbler.enable = true; # Thumbnail support for images thunar
  };

  programs.gnome-disks.enable = true;
}
