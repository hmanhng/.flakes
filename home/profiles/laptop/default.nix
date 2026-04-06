{
  imports = [
    # editors
    ../../editors
    ../../editors/antigravity
    ../../editors/zed.nix

    ../../programs
    ../../programs/wayland/niri

    ../../terminal/emulators/foot.nix
    ../../terminal/programs/llm.nix

    # system services
    # ../../services/system/polkit-agent.nix # use noctalia instead
    # ../../services/system/power-monitor.nix # use tuned for ez config
    # ../../services/system/udiskie.nix # use noctalia instead
  ];

  sops.gnupg.home = "/home/hmanhng/.local/share/gnupg";
  sops.gnupg.sshKeyPaths = [ ];
}
