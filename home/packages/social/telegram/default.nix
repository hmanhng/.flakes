{pkgs, ...}: {
  home.packages = with pkgs; [
    (telegram-desktop.overrideAttrs (old: rec {
      pname = "64Gram";
      version = "1.1.14";

      src = fetchFromGitHub {
        owner = "TDesktop-x64";
        repo = "tdesktop";
        rev = "v${version}";

        fetchSubmodules = true;
        hash = "sha256-+Cx4qh/zHyBYRBxeZLZATU2U/r8xF24R8AXnfFwl+Oo=";
      };
    }))
  ];
}
