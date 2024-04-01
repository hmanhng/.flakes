{
  imports = [
    ../../editors
    ../../editors/code
    ../../editors/emacs

    ../../programs
    ../../dev

    ../../services
  ];

  sops.gnupg.home = "/home/hmanhng/.local/share/gnupg";
  sops.gnupg.sshKeyPaths = [];
}
