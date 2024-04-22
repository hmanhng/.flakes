{inputs, ...}: {
  programs.nh = {
    enable = true;
    flake = "/home/hmanhng/.flakes";
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
