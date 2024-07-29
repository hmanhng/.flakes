{pkgs, ...}: {
  imports = [
    ./zathura
    # ./logseq.nix
  ];
  home.packages = with pkgs; [
    libreoffice
    teams-for-linux
  ];
}
