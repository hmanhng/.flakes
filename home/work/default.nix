{ pkgs, ... }:
{
  imports = [
    ./k8s.nix
  ];
  home.packages = [
    pkgs.awscli2
    pkgs.terraform
  ];
}
