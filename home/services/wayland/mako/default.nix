{pkgs, ...}: {
  home.packages = with pkgs; [libnotify];
  services.mako = {
    enable = true;
    font = "Liga CodeNewRoman Nerd Font 12";
    width = 300;
    height = 500;
    margin = "5";
    padding = "5";
    borderSize = 2;
    borderRadius = 1;
    backgroundColor = "#3A4353E6";
    borderColor = "#c0caf5";
    progressColor = "over #D89BE1";
    textColor = "#FAF4FC";
    defaultTimeout = 5000;
    extraConfig = ''
      text-alignment=center
      outer-margin=0, 0, 50, 0

      [urgency=high]
      border-color=#B45C65

      [category=bottom-center]
      anchor=bottom-center
    '';
    layer = "overlay";
  };
  xdg.dataFile."icons/svg" = {
    source = ./svg;
    recursive = true;
  };
}
