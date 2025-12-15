{ pkgs, ... }:
{
  home.packages = with pkgs; [ (eclipses.override { jdk = jdk21; }).eclipse-java ];
}
