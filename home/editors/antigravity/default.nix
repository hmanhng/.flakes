{ pkgs, inputs, ... }:
let
  # Định nghĩa các flag trong một biến để dễ quản lý
  gpu-flags = [
    "--disable-gpu-driver-bug-workarounds"
    "--ignore-gpu-blacklist"
    "--enable-gpu-rasterization"
    "--enable-zero-copy"
    "--enable-native-gpu-memory-buffers"
  ];

  # Lấy gói gốc từ input của bạn
  original-pkg = inputs.antigravity-nix.packages.x86_64-linux.default;

  # Tạo gói mới đã được bọc (wrapped)
  wrapped-antigravity = pkgs.symlinkJoin {
    name = "antigravity-wrapped";
    paths = [ original-pkg ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/antigravity \
        --add-flags "${builtins.concatStringsSep " " gpu-flags}"
    '';
  };
in
{
  home.packages = [
    wrapped-antigravity
  ];
}
