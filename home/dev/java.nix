{pkgs, ...}: {
  # home.packages = with pkgs; [javaPackages.openjfx21];
  programs.java = {
    enable = true;
    # package = pkgs.jdk21.override {enableJavaFX = true;};
  };
}
