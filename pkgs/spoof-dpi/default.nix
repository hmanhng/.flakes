{
  lib,
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "spoof-dpi";
  version = "0.8";
  src = fetchzip {
    url = "https://github.com/xvzc/SpoofDPI/releases/download/${version}/spoof-dpi-linux.tar.gz";
    sha256 = "sha256-LdnL2WRQwz4QSt74zPep5xFryEqgOiuaRAhJe69rNiE=";
    stripRoot = false;
  };
  installPhase = ''
    install -D spoof-dpi $out/bin/spoof-dpi
  '';
  meta = with lib; {
    description = "A simple and fast anti-censorship tool written in Go";
    homepage = "https://github.com/xvzc/SpoofDPI";
    license = licenses.asl20;
    mainProgram = "spoof-dpi";
    maintainers = with maintainers; [hmanhng];
  };
}
