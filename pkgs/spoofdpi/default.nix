{
  lib,
  stdenv,
  fetchzip,
  ...
}:
stdenv.mkDerivation rec {
  pname = "spoofdpi";
  version = "0.12.0";
  src = fetchzip {
    url = "https://github.com/xvzc/SpoofDPI/releases/download/v${version}/spoofdpi-linux-amd64.tar.gz";
    sha256 = "sha256-w6vVbmLzAq9XpKha8ZDpyRAPP5XQn8RbDUSLpRazzuM=";
    stripRoot = false;
  };
  installPhase = ''
    install -D spoofdpi $out/bin/spoofdpi
  '';
  meta = with lib; {
    description = "A simple and fast anti-censorship tool written in Go";
    homepage = "https://github.com/xvzc/SpoofDPI";
    license = licenses.asl20;
    mainProgram = "spoofdpi";
    maintainers = with maintainers; [hmanhng];
  };
}
