{ user, ... }:
{
  sops.defaultSopsFile = ./secrets.yaml;
  # sops.gnupg.sshKeyPaths = [ "/home/${user}/.ssh" ];
  # sops.age.sshKeyPaths = [ ];
  # sops.age.keyFile = "/nix/secret_key";
  # sops.secrets.ssh_key = {
  #   owner = "${user}";
  #   mode = "400";
  #   path = "/home/${user}/.ssh/id_rsa";
  # };
  # sops.secrets.keys_age = {
  #   owner = "${user}";
  #   mode = "400";
  #   path = "/home/${user}/.config/sops/age/keys.txt";
  # };
}
