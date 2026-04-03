{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  srcPath = "${config.home.homeDirectory}/.flakes/home/programs/wayland/noctalia";
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    package = (
      inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.override {
        calendarSupport = true;
      }
    );
  };

  home.packages = [
    pkgs.jq
  ];

  home.file = {
    # Link thủ công các file quan trọng ở gốc
    ".config/noctalia/plugins.json".source =
      config.lib.file.mkOutOfStoreSymlink "${srcPath}/plugins.json";
  };

  # GIẢI PHÁP TỰ ĐỘNG ĐỆ QUY
  home.activation.linkNoctaliaSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    # Tìm tất cả settings.json và link chúng (Out-of-Store)
    find "${srcPath}" -type f -name "settings.json" | while read -r FILE_PATH; do
        # Tính toán đường dẫn tương đối
        RELATIVE_PATH=''${FILE_PATH#${srcPath}/}
        REL_DIR=$(dirname "$RELATIVE_PATH")

        # Tạo folder đích và link
        $DRY_RUN_CMD mkdir -p "$HOME/.config/noctalia/$REL_DIR"
        $DRY_RUN_CMD ln -sfn "$FILE_PATH" "$HOME/.config/noctalia/$RELATIVE_PATH"
    done
  '';
}
