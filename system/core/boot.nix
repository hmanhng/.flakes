{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    initrd.systemd.enable = true;

    consoleLogLevel = 3; # "loglevel=3"
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "fbcon=nodefer"
      "plymouth.use-simpledrm"
    ];

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    plymouth.enable = true;
  };
}
