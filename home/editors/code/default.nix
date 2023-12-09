{pkgs, ...}: let
  code = pkgs.symlinkJoin {
    name = "code";
    inherit (pkgs.vscode) pname version;
    paths = [pkgs.vscode];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/code \
        --unset WAYLAND_DISPLAY \
        --append-flags "--enable-wayland-ime"
    '';
  };
in {
  programs.vscode = {
    enable = true;
    package = code;
    extensions = with pkgs.vscode-extensions; [
      bbenoist.nix
    ];
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
