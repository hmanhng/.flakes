{pkgs, ...}: {
  # Accelerated Video Playback
  hardware.opengl = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  boot.initrd.kernelModules = ["amdgpu"];
}
