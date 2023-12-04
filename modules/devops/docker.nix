{pkgs, ...}: {
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = ["hmanhng"];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
