{pkgs, ...}: {
  imports = [
    # ./discord.nix
  ];
  home.packages = with pkgs; [
    _64gram
    vesktop
  ];
}
