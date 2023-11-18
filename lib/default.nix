{inputs, ...}:
# personal lib
let
  inherit (inputs.nixpkgs) lib;
in {
  imports = [
    {
      # get default across the module system
      _module.args = {default = import ./base {inherit lib;};};
    }
  ];
  perSystem = {system, ...}: {
    legacyPackages = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
      ];
    };
  };
}
