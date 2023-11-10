{
  inputs',
  pkgs,
  ...
}: {
  programs.yazi = {
    enable = true;
    /*
    package = inputs'.yazi.packages.yazi;
    */
    enableFishIntegration = true;
  };

  home.file = {
    ".config/yazi/yazi.toml".source = ./yazi.toml;
    ".config/yazi/keymap.toml".source = ./keymap.toml;
    ".config/yazi/theme.toml".source = ./theme.toml;
  };
  home.packages = with pkgs; [
    exiftool
    mediainfo
  ];
}
