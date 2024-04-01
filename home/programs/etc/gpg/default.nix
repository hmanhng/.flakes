{
  config,
  pkgs,
  ...
}: {
  programs.gpg = {
    enable = true;
    package = pkgs.gnupg;
    homedir = "${config.xdg.dataHome}/gnupg";
  };

  services.gpg-agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };
}
