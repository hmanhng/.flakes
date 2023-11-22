{user, ...}: {
  imports = [
    ../../editors
    ../../packages
    ../../wayland
    ../../dev
  ];

  sops.gnupg.sshKeyPaths = ["/home/${user}/.ssh/id_rsa"];
}
