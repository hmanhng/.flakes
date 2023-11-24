{
  user,
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
          ../modules/desktop.nix
          ../modules/impermanence.nix
          # ../modules/devops
          ../secrets/secrets.nix
          # ../modules/virtual
          {
            home-manager.users.${user}.imports =
              homeImports."hmanhng@laptop";
          }
        ]
        ++ sharedModules;
    };
  };
}
