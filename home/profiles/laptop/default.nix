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
    ../../services/system/power-monitor.nix
    ../../services/system/udiskie.nix

    # wayland services
    ../../services/wayland/hyprsunset.nix
  ];

  sops.gnupg.home = "/home/hmanhng/.local/share/gnupg";
  sops.gnupg.sshKeyPaths = [ ];
}
