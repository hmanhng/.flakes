{
  imports = [
    ../../editors
    ../../packages
    ../../wayland
    ../../dev
  ];

  sops.gnupg.sshKeyPaths = ["/home/hmanhng/.ssh/id_rsa"];
}
