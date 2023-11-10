{ pkgs, ... }:
{
  home.packages = with pkgs; [
    jetbrains.idea-community
  ];
  programs.java = {
    enable = true;
    package = pkgs.jetbrains.jdk;
  };
}
