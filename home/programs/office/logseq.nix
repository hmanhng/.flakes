{ pkgs, ... }:
let
  logseq = pkgs.symlinkJoin {
    name = "logseq";
    inherit (pkgs.logseq) pname version;
    paths = [ pkgs.logseq ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/logseq \
        --add-flags "--enable-wayland-ime"
    '';
  };
in
{
  home.packages = [
    logseq
  ];
}
