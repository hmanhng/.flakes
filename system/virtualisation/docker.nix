{
  virtualisation.docker = {
    enable = true;
  };
  users.users.hmanhng.extraGroups = [ "docker" ];
}
