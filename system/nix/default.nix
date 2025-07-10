{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./nh.nix
    ./nixpkgs.nix
    # ./substituters.nix
  ];

  # we need git for flakes
  environment.systemPackages = [pkgs.git];

  nix = let
    flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
  in {
    package = pkgs.lix;

    # pin the registry to avoid downloading and evaling a new nixpkgs version every time
    registry = lib.mapAttrs (_: v: {flake = v;}) flakeInputs;

    # set the path for channels compat
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;

    settings = {
      accept-flake-config = true;
      warn-dirty = false;
      auto-optimise-store = true; # Optimise syslinks
      builders-use-substitutes = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
      flake-registry = "/etc/nix/registry.json";
      use-xdg-base-directories = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;

      trusted-users = ["root" "@wheel"];
    };
  };
}
