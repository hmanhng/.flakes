{pkgs, ...}: {
  imports = [
    ./zathura
    # ./logseq
  ];
  home.packages = with pkgs; [
    teams-for-linux
  ];
}
