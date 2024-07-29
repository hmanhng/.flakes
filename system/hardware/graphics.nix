{pkgs, ...}: {
  # graphics drivers / HW accel
  hardware.graphics = {
    enable = true;

    extraPackages = with pkgs; [
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];

    enable32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [
      libva
      vaapiVdpau
      libvdpau-va-gl
    ];
  };
}
