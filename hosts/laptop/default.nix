{
  # inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./hyprland.nix
  ];

  networking.hostName = "laptop"; # Define your hostname.

  security.tpm2.enable = true;

  services = {
    # for SSD/NVME
    fstrim.enable = true;

    # howdy = {
    #   enable = true;
    #   package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.stdenv.hostPlatform.system}.howdy;
    #   settings = {
    #     core = {
    #       no_confirmation = true;
    #       abort_if_ssh = true;
    #     };
    #     video.dark_threshold = 90;
    #   };
    # };

    # linux-enable-ir-emitter = {
    #   enable = true;
    #   package = inputs.nixpkgs-howdy.legacyPackages.${pkgs.stdenv.hostPlatform.system}.linux-enable-ir-emitter;
    # };
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
