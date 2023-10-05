{ pkgs, inputs, user, ... }:
{
  nix = {
    settings = {
      warn-dirty = false;
      accept-flake-config = true;
      trusted-users = [ "root" "${user}" ];
      builders-use-substitutes = true;
      auto-optimise-store = true; # Optimise syslinks
      experimental-features = [ "nix-command" "flakes" ];
      use-xdg-base-directories = true;

      # for direnv GC roots
      keep-derivations = true;
      keep-outputs = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
    package = pkgs.nixVersions.unstable;
    registry.nixpkgs.flake = inputs.nixpkgs;
    extraOptions = ''
    '';
  };
  nixpkgs.config.allowUnfree = true;
}
