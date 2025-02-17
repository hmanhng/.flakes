{pkgs, ...}: {
  imports = [
    ./discord
  ];

  home.packages = with pkgs; [
    _64gram
    vesktop
  ];

  # sys.discord.enable = true;
}
