{inputs, ...}: {
  imports = [
    inputs.nh.nixosModules.default
  ];

  environment.variables.FLAKE = "/home/hmanhng/.flakes";

  nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 30d";
    };
  };
}
