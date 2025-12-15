{ pkgs, ... }:
{
  # graphics drivers / HW accel
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      libva
      libva-vdpau-driver
      libvdpau-va-gl
    ];

    enable32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };
}
