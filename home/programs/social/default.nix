{pkgs, ...}: {
  imports = [
  ];
  home.packages = with pkgs; [
    _64gram
    discord
  ];
}
