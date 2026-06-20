{ pkgs, ... }:
{
  home.packages = [
    pkgs.kubectl
    pkgs.minikube
    pkgs.kubectx
    pkgs.kubernetes-helm
  ];

  programs.fish = {
    plugins = [
      {
        name = "kubectl";
        src = pkgs.fetchFromGitHub {
          owner = "ssoriche";
          repo = "kubectl.fish";
          rev = "37206f7710dcd31f95e653bce154c2990021e7bf";
          sha256 = "sha256-RzicxGynal8DM2euq6Vg8uwDVtkRJ7hKZ40v6Q+ulww=";
        };
      }
    ];
  };
}
