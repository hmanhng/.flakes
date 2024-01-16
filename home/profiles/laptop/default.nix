{
  imports = [
    ../../editors
    ../../editors/code
    ../../editors/emacs

    ../../packages
    ../../dev

    ../../services
  ];

  sops.gnupg.sshKeyPaths = ["/home/hmanhng/.ssh/id_rsa"];
}
