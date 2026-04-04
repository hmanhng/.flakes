{
  imports = [
    # editors
    ../../editors
    ../../editors/code
    ../../editors/emacs
    ../../editors/antigravity

    ../../programs
    ../../programs/wayland/niri

    ../../dev

    ../../cli/llm.nix

    # system services
    # ../../services/system/polkit-agent.nix # use noctalia instead
    # ../../services/system/power-monitor.nix # use tuned for ez config
    # ../../services/system/udiskie.nix # use noctalia instead
  ];

  sops.gnupg.home = "/home/hmanhng/.local/share/gnupg";
  sops.gnupg.sshKeyPaths = [ ];
}
