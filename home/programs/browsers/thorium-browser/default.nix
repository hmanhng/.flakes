{
  self,
  pkgs,
  ...
}: {
  home.packages = [self.legacyPackages.${pkgs.stdenv.hostPlatform.system}.thorium-browser];

  home = {
    sessionVariables = {
      CHROME_EXTRA_FLAGS = "
      --enable-wayland-ime
      --ozone-platform-hint=auto
      --enable-features=TouchpadOverscrollHistoryNavigation
      --enable-features=VaapiVideoDecodeLinuxGL
      # --high-dpi-support=1
      # --force-device-scale-factor=2
      ";
    };
  };
}
