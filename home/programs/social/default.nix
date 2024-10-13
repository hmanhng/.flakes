{pkgs, ...}: {
  imports = [
    ./discord
  ];

  home.packages = with pkgs; [
    _64gram
  ];

  sys.discord.enable = true;
}
