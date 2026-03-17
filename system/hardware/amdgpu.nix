{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.amdgpu_top
  ];

  hardware.amdgpu.opencl.enable = true;

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  hardware.amdgpu.initrd.enable = true; # sets boot.initrd.kernelModules = ["amdgpu"];
}
