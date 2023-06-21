{ lib, stdenv, fetchzip, ... }:

stdenv.mkDerivation rec {
  pname = "spoof-dpi";
  version = "0.7";
  src = fetchzip {
    url = "https://github.com/xvzc/SpoofDPI/releases/download/${version}/spoof-dpi-linux.tar.gz";
    sha256 = "sha256-Z9R6mCTwK/bJL7btM+oaKsJg7yXw4n+I/BYdtYWO7WI=";
    stripRoot = false;
  };
  installPhase = ''
    install -D spoof-dpi $out/bin/spoof-dpi
  '';
  meta = with lib; {
    description = "A simple and fast anti-censorship tool written in Go";
    homepage = "https://github.com/xvzc/SpoofDPI";
    license = licenses.asl20;
    maintainers = with maintainers; [ hmanhng ];
  };
}
