{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  systemd,
  v4l-utils,
  argparse,
  gtk3,
  python3,
  spdlog,
  usbutils,
  yaml-cpp,
}:

stdenv.mkDerivation rec {
  pname = "linux-enable-ir-emitter";
  version = "7.0.0-beta2";

  src = fetchurl {
    url = "https://github.com/EmixamPP/linux-enable-ir-emitter/releases/download/7.0.0-beta/${pname}-${version}-release-x86-64.tar.gz";
    hash = "sha256-98SDI9YIKRqW6kOaI/RdTdkP7NW2uF1/5Cuqcvm3kEs=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    argparse
    gtk3
    spdlog
    usbutils
    yaml-cpp
    python3.pkgs.opencv4Full
  ];

  sourceRoot = ".";

  # No build needed, it's a prebuilt binary
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    # Install the prebuilt binary
    install -Dm755 linux-enable-ir-emitter $out/bin/linux-enable-ir-emitter

    runHook postInstall
  '';

  meta = with lib; {
    description = "Enables your IR emitter on Linux (beta version)";
    homepage = "https://github.com/EmixamPP/linux-enable-ir-emitter";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
    maintainers = [ ];
    mainProgram = "linux-enable-ir-emitter";
  };
}
