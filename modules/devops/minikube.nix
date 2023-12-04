{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kubectl
    minikube
  ];
  home-manager.users.hmanhng = {
    home.sessionVariables = {
      MINIKUBE_HOME = "$HOME/.local/share/minikube";
    };
  };
  environment.persistence."/nix/persist" = {
    users.hmanhng = {
      directories = [
        ".kube"
      ];
    };
  };
}
