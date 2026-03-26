{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.kubectl
    pkgs.minikube
  ];
}
