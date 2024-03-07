{
  imports = [
    ../../editors
    ../../editors/code
    ../../editors/emacs

    ../../programs
    ../../dev

    ../../services
  ];

  sops.gnupg.sshKeyPaths = ["/home/hmanhng/.ssh/id_rsa"];
}
