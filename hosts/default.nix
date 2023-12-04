{
  sharedModules,
  inputs,
  homeImports,
  ...
}: {
  flake.nixosConfigurations = let
    inherit (inputs.nixpkgs.lib) nixosSystem;
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
        ]
        ++ sharedModules;
    };
  };
}
