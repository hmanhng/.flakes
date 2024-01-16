{
  lib,
  inputs,
  ...
}: {
  # _module.args = {default = import ./base lib;};
  # perSystem = {system, ...}: {
  #   legacyPackages = import inputs.nixpkgs {
  #     inherit system;
  #     config.allowUnfree = true;
  #     overlays = [
  #     ];
  #   };
  # };
}
