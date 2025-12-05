{pkgs, ...}: {
  # home.packages = with pkgs; [javaPackages.openjfx21];
  programs.java = {
    enable = true;
    # package = pkgs.jdk17.override {enableJavaFX = true;};
  };
}
