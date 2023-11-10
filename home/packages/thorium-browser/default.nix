{self', ...}: {
  home.packages = [self'.legacyPackages.thorium-browser];

  home = {
    sessionVariables = {
      CHROME_EXTRA_FLAGS = "
      --high-dpi-support=1
      --force-device-scale-factor=1.2
      ";
    };
  };
}
