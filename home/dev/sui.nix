{
  pkgs,
  self,
  ...
}: {
  home.packages = with pkgs; [
    self.legacyPackages.${system}.sui
  ];
}
