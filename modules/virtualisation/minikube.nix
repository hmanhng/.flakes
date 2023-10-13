{ user, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    kubectl
    minikube
  ];
  home-manager.users.${user} = {
    home.sessionVariables = {
      MINIKUBE_HOME = "$HOME/.local/share/minikube";
    };
  };
  environment.persistence."/nix/persist" = {
    users.${user} = {
      directories = [
        ".kube"
      ];
    };
  };
}
