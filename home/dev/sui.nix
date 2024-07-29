{
  pkgs,
  self,
  ...
}: {
  home.packages = with pkgs; [
    self.legacyPackages.${pkgs.system}.sui
  ];
}
