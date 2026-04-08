{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "dank-mono-fonts";
  version = "unstable-2026-04-08";

  src = fetchFromGitHub {
    owner = "hmanhng";
    repo = "my-fonts";
    rev = "main";
    hash = "sha256-hvNWB1ja+DjdKyEMeGUNzPhVdsz705d1x+G/QSdSbgo=";
  };

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "DankMono Nerd Font/DankMonoNerdFont-Regular.otf" "$out/share/fonts/opentype/DankMonoNerdFont-Regular.otf"
    install -Dm644 "DankMono Nerd Font/DankMonoNerdFont-Italic.otf" "$out/share/fonts/opentype/DankMonoNerdFont-Italic.otf"
    install -Dm644 "DankMono Nerd Font/DankMonoNerdFont-Bold.otf" "$out/share/fonts/opentype/DankMonoNerdFont-Bold.otf"

    install -Dm644 "DankMono Nerd Font/DankMonoNerdFontMono-Regular.otf" "$out/share/fonts/opentype/DankMonoNerdFontMono-Regular.otf"
    install -Dm644 "DankMono Nerd Font/DankMonoNerdFontMono-Italic.otf" "$out/share/fonts/opentype/DankMonoNerdFontMono-Italic.otf"
    install -Dm644 "DankMono Nerd Font/DankMonoNerdFontMono-Bold.otf" "$out/share/fonts/opentype/DankMonoNerdFontMono-Bold.otf"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Dank Mono Nerd Font (including mono variants)";
    homepage = "https://github.com/hmanhng/my-fonts";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
