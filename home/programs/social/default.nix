{pkgs, ...}: {
  imports = [
    ./discord
  ];

  home.packages = with pkgs; [
    _64gram
    legcord
  ];

  # sys.discord.enable = true;
}
