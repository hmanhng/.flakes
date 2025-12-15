{ pkgs, ... }:
let
  code = pkgs.symlinkJoin {
    name = "code";
    inherit (pkgs.vscode-fhs) pname version;
    paths = [ pkgs.vscode-fhs ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/code \
        --append-flags "--enable-wayland-ime"
    '';
    # --unset WAYLAND_DISPLAY \
  };
in
{
  programs.vscode = {
    enable = true;
    package = code;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        bbenoist.nix
      ];
    };
    /*
         userSettings = {
        "files.autoSave" = "off";
        "[nix]"."editor.tabSize" = 2;
        "window.zoomLevel" = 1.2;
        "editor.fontFamily" = "Liga CodeNewRoman Nerd Font";
        "editor.fontSize" = 19;
      };
    */
  };
}
