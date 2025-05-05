{pkgs, ...}: {
  imports = [
    ./zathura.nix
    # ./logseq.nix
  ];
  home.packages = with pkgs; [
    libreoffice
    teams-for-linux
  ];
}
