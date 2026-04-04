{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./howdy.nix
  ];

  networking.hostName = "laptop"; # Define your hostname.

  security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;
  };

  hardware = {
    sensor.iio.enable = true;
  };

  boot = {
    kernelModules = [
      "i2c-dev" # used by ddcutil
    ];
    kernelPackages = lib.mkForce pkgs.linuxPackages_latest;
    kernelParams = [
      "amd_pstate=active"
      ''acpi_osi="Windows 2020"''
      "amdgpu.dcfeaturemask=0x8"
    ];
    blacklistedKernelModules = [
      # "ideapad_laptop" # fix https://bbs.archlinux.org/viewtopic.php?id=295464
    ];
  };
}
