{
  imports = [
    ../../editors
    ../../editors/code
    ../../editors/emacs
    ../../editors/antigravity

    ../../programs
    ../../dev

    ../../services
    ../../services/system/power-monitor.nix
  ];

  sops.gnupg.home = "/home/hmanhng/.local/share/gnupg";
  sops.gnupg.sshKeyPaths = [ ];
}
