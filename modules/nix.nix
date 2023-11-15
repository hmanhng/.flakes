{
  config,
  lib,
  inputs,
  ...
}: {
  environment.variables.FLAKE = "/home/hmanhng/.flakes";
  nh = {
    enable = true;
    # weekly cleanup
    clean.enable = true;
  };

  nix = {
    distributedBuilds = true;

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) inputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      accept-flake-config = true;
      warn-dirty = false;
      auto-optimise-store = true; # Optimise syslinks
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes"];
      flake-registry = "/etc/nix/registry.json";
      use-xdg-base-directories = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        # "https://helix.cachix.org"
        "https://hmanhng.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        # "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
        "hmanhng.cachix.org-1:+pXFpN2CtS0rNUdCdeiOu6QUWMVBX0nCbWREhfiiKtI="
      ];
      trusted-users = ["root" "@wheel"];
    };
  };
  nixpkgs.config.allowUnfree = true;
}
