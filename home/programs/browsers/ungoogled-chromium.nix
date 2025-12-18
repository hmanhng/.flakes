{
  self,
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.ungoogled-chromium ];

  home = {
    sessionVariables = {
      CHROME_EXTRA_FLAGS = "
      --enable-wayland-ime
      --ozone-platform-hint=auto
      --enable-features=TouchpadOverscrollHistoryNavigation
      --enable-features=AcceleratedVideoDecodeLinuxGL
      --enable-features=AcceleratedVideoDecodeLinuxZeroCopyGL
      --force-device-scale-factor=1
      ";
    };
  };
}
