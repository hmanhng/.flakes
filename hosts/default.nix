{
  inputs,
  sharedModules,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
    howdy = inputs.nixpkgs-howdy;
  in {
    laptop = nixosSystem {
      specialArgs = {inherit inputs;};
      modules =
        [
          ./laptop
          ../secrets
          ../modules/dev.nix
          ../modules/desktop
          ../modules/impermanence
          ../modules/impermanence/btrfs.nix
          ../modules/virtual
          # ../modules/devops
          {home-manager.users.hmanhng.imports = homeImports."hmanhng@laptop";}
          {disabledModules = ["security/pam.nix"];}
          "${howdy}/nixos/modules/security/pam.nix"
          "${howdy}/nixos/modules/services/security/howdy"
          # "${howdy}/nixos/modules/services/misc/linux-enable-ir-emitter.nix"
        ]
        ++ sharedModules;
    };
  };
}
