{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    # package = inputs.yazi.packages.${pkgs.system}.yazi;
    enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    exiftool
    mediainfo
  ];
}
