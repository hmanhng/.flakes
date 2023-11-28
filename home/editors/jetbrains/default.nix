{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    jetbrains.idea-community
  ];
}
