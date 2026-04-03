{
  imports = [
    # editors
    ../../editors
    ../../editors/code
    ../../editors/emacs
    ../../editors/antigravity

    ../../programs

    ../../dev

    ../../cli/llm.nix

    # system services
    ../../services/system/polkit-agent.nix
    # ../../services/system/power-monitor.nix # use tuned for ez config
    # ../../services/system/udiskie.nix # use noctalia instead

    # wayland services
    # ../../services/wayland/hyprsunset.nix # use noctalia instead
  ];

  sops.gnupg.home = "/home/hmanhng/.local/share/gnupg";
  sops.gnupg.sshKeyPaths = [ ];
}
