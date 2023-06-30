/* {
  flake.overlays.default = rec {
  overlay = final: prev:
      let
        dirContents = builtins.readDir ../pkgs;
        genPackage = name: {
          inherit name;
          value = final.callPackage (../pkgs + "/${name}") { };
        };
        names = builtins.attrNames dirContents;
      in
      builtins.listToAttrs (map genPackage names);
  }.overlay;
} */
{
  systems = [ "x86_64-linux" ];

  perSystem = { pkgs, ... }:
    let
      dirContents = builtins.readDir ../pkgs;
      genPackage = name: {
        inherit name;
        value = pkgs.callPackage (../pkgs + "/${name}") { };
      };
      names = builtins.attrNames dirContents;
    in
    {
      legacyPackages = builtins.listToAttrs (map genPackage names);
    };
}
