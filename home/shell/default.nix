{
  imports = [
    #./zsh/zsh.nix
    ./fish
    # ./bash
    ./git
  ];
  programs.nix-index-database.comma.enable = true;
}
