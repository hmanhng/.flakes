{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  environment.systemPackages = with pkgs; [ sops ];
  sops.defaultSopsFile = ./secrets.yaml;
  sops.age.sshKeyPaths = [ ];
  sops.gnupg.sshKeyPaths = [ "/home/hmanhng/.ssh/id_rsa" ];
  # sops.gnupg.sshKeyPaths = [ "/home/hmanhng/.ssh" ];
  # sops.age.sshKeyPaths = [ ];
  # sops.age.keyFile = "/nix/secret_key";
  # sops.secrets.ssh_key = {
  #   owner = "hmanhng";
  #   mode = "400";
  #   path = "/home/hmanhng/.ssh/id_rsa";
  # };
  # sops.secrets.keys_age = {
  #   owner = "hmanhng";
  #   mode = "400";
  #   path = "/home/hmanhng/.config/sops/age/keys.txt";
  # };
}
